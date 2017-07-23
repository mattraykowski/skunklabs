# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lab_supporter do
    user
    lab
  end
end
