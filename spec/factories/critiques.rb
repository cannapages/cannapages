# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :critique do
    title "MyString"
    content "MyString"
    views 1
    likes 1
  end
end
