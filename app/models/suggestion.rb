class Suggestion < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :team_member, class_name: "User", foreign_key: "team_member_id"
  belongs_to :status, class_name: "SuggestionState", foreign_key: "status_id"
  
  has_many :suggestion_votes
  
  validates :title, presence: true
  validates :description, presence: true
  validates :creator, presence: true
  
  def can_modify(user)
    if user.suggestion_team_member || creator.id == user.id
      true
    else
      false
    end 
  end
end
