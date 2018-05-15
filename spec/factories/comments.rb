# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :comment do    
    comment "MyText"
    subject "MyString"
    is_update false
    progress 0
  end
end
