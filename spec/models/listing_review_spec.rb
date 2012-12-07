require 'spec_helper'

describe ListingReview do

	let(:the_listing_review) do
		reviews = []
		listing_review = ListingReview.new
		5.times do |i|
			listing_review.reviews << Review.new( rating: i + 1 )
		end
		listing_review
	end

	it "Should have a working fixture" do
		the_listing_review.save
		ListingReview.count.should eql 1
	end

	it "Should have a function for returning the average of all reviews" do
		the_listing_review.average_rating.should eql 3.0
	end

	it "The average review should be a float acurate to one decimal place" do
		the_listing_review.reviews << Review.new( rating: 5 )
		the_listing_review.reviews << Review.new( rating: 4 )
		the_listing_review.average_rating.should eql 3.4
	end

end
