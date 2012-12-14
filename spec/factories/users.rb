# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
		sequence :email do |n|
			"bob#{n}@domain.com"
		end
		sequence :user_name do |n|
			"bob#{n}"
		end
		password "abcd1234"
		password_confirmation "abcd1234"
  end
end
