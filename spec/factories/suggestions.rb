# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :suggestion do
    title "MyString"
    description "MyText"
    trait :with_creator do
      creator { create(:user) }
    end
    status { create(:suggestion_state) }
    completion_date "2014-03-31 13:25:11"
    notes "MyText"
  end
end
