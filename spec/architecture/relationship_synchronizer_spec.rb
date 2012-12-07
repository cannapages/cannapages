require 'spec_helper'

describe RelationshipSynchronizer do

	# Reivews and Comments
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
	let(:the_user) do
		User.new  email: "someone@somewhere.com",
							password: "abcd1234",
							password_confirmation: "abcd1234"
	end
	
	it "Should facilitate the creation of raitings and comments" do
		the_comment = Comment.new body: "These guys were like so.... awesome"
		the_review = Review.new rating: 5 
		RelationshipSynchronizer::Review::Create the_user, the_listing, the_comment, the_review
		
		the_listing.relaod
		the_comment.reload

		the_listing.rating.should be 5
		the_listing.num_of_reviews.should be 1

		the_listing.listing_review.reviews.first.rating.should be 1
		the_listing.listing_review.reviews.size.should be 1

		the_listing.comments.first.body.should be "These guys were like so.... awesome"
		the_listing.comments.first.rating.should be 5
	end
	
end
