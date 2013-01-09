# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    strain_name "MyString"
    strain_id "MyString"
    quantity_in_stock 10
    price_1_8 25.5
    price_1_4 45.5
    price_1_2 80.5
    price_whole 150.5
  end
end
