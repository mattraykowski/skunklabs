FactoryGirl.define do
  factory :user do
    email "test@user.com"
    password "testpassword"
    password_confirmation "testpassword"
    login 'testuser'
  end
end