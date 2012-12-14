# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :listing do
		sequence :name do |n| 
			"Listing#{n}"
		end
		about "We are a blah blah and do blah"
    sequence :phone do |n| 
			"bob#{n}@gmail.com"
		end
    sequence :street_address do |n| 
			"#{n}2345 Fake st"
		end
    city "Denver"
    state "Colorado"
    zip "80003"
		website "www.google.com"
		twitter "www.twitter.com"
		facebook "www.facebook.com"	
    category "Dispensary"
		match_coupons true
		glass_sale true
		whole_sale true
  end
end
