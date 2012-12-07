require 'spec_helper'

describe Review do

	let(:the_listing_review) do
		reviews = []
		listing_review = ListingReview.new
		5.times do |i|
			listing_review.reviews << Review.new( rating: i + 1 )
		end
		listing_review
	end

	it "Should have a working factory" do
		the_listing_review.save.should be_true
	end

end
