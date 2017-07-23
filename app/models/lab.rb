class Lab < ActiveRecord::Base
  PROPOSED  = 0
  STARTED   = 1
  COMPLETED = 2
  BLOCKED   = 3
  ABANDONED = 4

  STATUSES = {
    PROPOSED  => 'proposed',
    STARTED   => 'started',
    COMPLETED => 'completed',
    BLOCKED   => 'blocked',
    ABANDONED => 'abandoned'
  }

  belongs_to :user
  belongs_to :focus_type
  has_many   :team_roles
  has_many   :comments, -> { order('created_at DESC') }
  has_many   :link_resources
  has_many   :lab_supporters

  validates :name, presence: true
  validates :goals, presence: true
  validates :measurements, presence: true
  validates :focus_type, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES.keys, message: 'Not a valid status' }

  def is_team_member?(user)
    is_member = false
    if user
      team_roles.each do |team_role|
        if team_role.user
          if team_role.user.id == user.id
            is_member = true
            break
          end
        end
      end
    end
    is_member
  end

  def is_owner?(other_user)
    if other_user.nil?
      false
    elsif other_user.id == user.id
      true
    else
      false
    end
  end

  def lab_watchers
    lab_watchers = Array.new
    # The owner is implicitly a watcher.
    lab_watchers.push user

    # The team members are implicitly watchers.
    team_roles.each do |team_role|
      lab_watchers.push team_role.user unless team_role.user.nil?
    end

    # The labs supporters are explicit watchers.
    lab_supporters.each do |supporter|
      lab_watchers.push supporter.user
    end

    lab_watchers
  end

  def overall_progress
    comments = Comment.find_by_sql("select * from comments a " +
                                   "where a.progress is not null " +
                                   "and a.is_update = 't' " +
                                   "and a.lab_id = #{self.id} " +
                                   "and a.user_id in (" +
                                   "  select distinct c.user_id " +
                                   "  from team_roles c " +
                                   "  where c.lab_id = a.lab_id)" +
                                   "and a.created_at = (" +
                                   "  select max(b.created_at) " +
                                   "  from comments b " +
                                   "  where b.user_id=a.user_id " +
                                   "  and b.lab_id=a.lab_id " +
                                   "  and b.progress is not null " +
                                   "  and b.is_update = 't')")


    if comments.size == 0
      return 0
    end

    avg = 0
    comments.each do |comment|
      avg += comment.progress
    end

    avg / comments.size
  end

  def status_name
    STATUSES[status]
  end

  def transition_okay?(to_status)
    valid_statuses = Array.new

    if status == Lab::PROPOSED
      valid_statuses = [ Lab::STARTED ]
    elsif status == Lab::STARTED
      valid_statuses = [ Lab::COMPLETED, Lab::BLOCKED, Lab::ABANDONED ]
    elsif status == Lab::BLOCKED
      valid_statuses = [ Lab::STARTED, Lab::ABANDONED ]
    end

    if valid_statuses.include? to_status
      true
    else
      false
    end
  end
end
