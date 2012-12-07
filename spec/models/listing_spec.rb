require 'spec_helper'
require 'models/helpers'

describe Listing do

	let(:buddies) do
		Listing.new name: "Buddies Wellness",
								about: "We are dedicated to blah blah and do stuff like blah to ensure blah",
								phone: "5551234567",
								street_address: "12345 Fake St.",
								city: "Denver",
								state: "Colorado",
								zip: "80003",
								category: "Dispensary",
								website: "http://buddies.com",
								twitter: "http://twitter.com/buddies",
								facebook: "http://facebook.com/buddies",
								match_coupons: true,
								glass_sale: true,
								whole_sale: true
	end

	it "Should save sucsessfully with proper attributes" do
		buddies.save.should be_true
	end

	it "Should have working time stamps" do
		buddies.should respond_to :updated_at
		buddies.should respond_to :created_at
	end

	it "Should take many phone formats in and always percist with no special characters" do
		change_attr_and_assert(buddies, :phone, "(555) 123-4567") { |phone| phone.should eql("5551234567") }
		change_attr_and_assert(buddies, :phone, "(555)123-4567") { |phone| phone.should eql("5551234567") }
		change_attr_and_assert(buddies, :phone, "555-123-4567") { |phone| phone.should eql("5551234567") }
	end

	it "Should remove all but the last 10 digets for a phone number ignore +1 etc" do
		change_attr_and_assert(buddies, :phone, "+1 555-123-4567") { |phone| phone.should eql("5551234567") }
	end

	it "Should have a method to return a full address" do
		buddies.full_address.should eq "#{buddies.street_address} #{buddies.city}, #{buddies.state} #{buddies.zip}"
	end

	it "Should derive lat and lng from address before save" do
		buddies.lat.should be_nil
		buddies.lng.should be_nil

		buddies.save
		buddies.lat.should_not be_nil
		buddies.lng.should_not be_nil
	end

	it "Should not use geo services if address hasn't changed" do
		buddies.save
		buddies.should_not_receive :update_lat_lng
		buddies.save
	end

	it "Should add http:// if not given for external urls" do
		buddies.website = "buddies.com"
		buddies.save
		buddies.website.should eql "http://buddies.com"
	end

	it "Should auto initialize anylitcs on a newly created instance" do
		buddies.save
		buddies.shows.should eql 0
		buddies.clicks.should eql 0
		buddies.featured_shows.should eql 0
		buddies.featured_clicks.should eql 0
	end

	it "Should force state to be in a legal state" do
		buddies.state = "NonLegalState"
		buddies.should_not be_valid
	end

	it "Should force category to be in the app wide category array" do
		buddies.category = "WrongCategory"
		buddies.should_not be_valid
	end

	it "Should create a new ListingReview on creation" do
		buddies.save
		buddies.listing_review.class.should be ListingReview
	end

end
