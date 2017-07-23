class SuggestionVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :suggestion
  
  validates :user_id, uniqueness: { scope: :suggestion_id, message: "You can only vote once for a suggestion." }
end
