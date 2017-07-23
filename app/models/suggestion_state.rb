class SuggestionState < ActiveRecord::Base
  
  validates :name, presence: true
end
