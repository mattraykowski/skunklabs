# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :link_resource do
    lab
    name "MyString"
    url "MyString"
    description "MyText"
  end
end
