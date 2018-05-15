# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :suggestion_vote do
    user
    suggestion    
  end
end
