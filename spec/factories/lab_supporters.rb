# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :lab_supporter do
    user
    lab
  end
end
