class TeamRole < ActiveRecord::Base
  belongs_to :lab
  belongs_to :role_type
  belongs_to :user

  validates :lab, presence: true
  validates :role_type, presence: true

  def progress
    role_progress = 0
    if user
      comment = Comment.where(user: self.user, lab: self.lab, is_update: true).order('created_at DESC').first

      if comment
        role_progress = comment.progress ? comment.progress : 0
      end
    end

    role_progress
  end
end
