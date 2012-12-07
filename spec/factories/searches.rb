# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :search do
    query "MyString"
    user_location "MyString"
  end
end
