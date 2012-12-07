# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body "MyString"
    rating 1
    user_name "MyString"
    user_email "MyString"
  end
end
