# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :strain do
    strain_name "Maui"
    dominance "Indica"
    thc 13.06
    cbd 0.04
    cbn 0.02
    total_cannabinoids 13.12
  end
end
