# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :suggestion_vote do
    user
    suggestion    
  end
end
