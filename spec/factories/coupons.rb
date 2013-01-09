# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :coupon do
    deal "MyString"
    expires false
    expiration_date "2013-01-08"
  end
end
