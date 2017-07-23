FactoryGirl.define do
  factory :team_role do
    lab
    role_type
    comment 'test comment'

    trait :with_user do
      user
    end
  end
end
