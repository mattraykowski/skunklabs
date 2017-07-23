# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link_resource do
    lab
    name "MyString"
    url "MyString"
    description "MyText"
  end
end
