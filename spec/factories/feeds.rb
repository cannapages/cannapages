# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feed do
    name "MyString"
    url "MyString"
    articles_fetched 1
    failures 1
  end
end
