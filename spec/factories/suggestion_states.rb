# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :suggestion_state do
    name "MyString"
    done false
  end
end
