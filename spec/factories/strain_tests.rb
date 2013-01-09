# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :strain_test do
    strain_name "Maui"
    business_name "Cronic Building 10"
    test_date Date.today
    dominance "Indica"
    thc 13.06
    cbd 0.04
    cbn 0.02
    total_cannabinoids 13.12
  end
end
