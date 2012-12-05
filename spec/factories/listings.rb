# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :listing do
    name "MyString"
    phone "MyString"
    street_address "MyString"
    city "MyString"
    state "MyString"
    zip "MyString"
    category "MyString"
  end
end
