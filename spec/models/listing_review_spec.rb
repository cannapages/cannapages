require 'spec_helper'

describe ListingReview do

	let!(:users) do
		users = []
		5.times do
			users << FactoryGirl.create(:user)
		end
		users
	end

	let!(:listing) do
		l = FactoryGirl.build(:listing)
		l.save
		l
	end

	let!(:the_listing_review) do
		reviews = []
		listing_review = listing.listing_review
		5.times do |i|
			listing_review.reviews << Review.new( rating: i + 1, user_id: users[i].id )
		end
		listing_review.save
		listing.save
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

	it "Should update its Listing rating with its average rating on update, creation or deletion of one of its reviews" do
		listing.save
		the_listing_review.save
		
		listing.rating.should eql 3.0
		listing.listing_review.reviews << Review.new( rating: 5 )
		listing.listing_review.save
		listing.rating.should eql 3.3
	end

	it "Should update its parrent number of reviews" do
		old_num_of_reviews = listing.num_of_reviews

		listing_review = listing.listing_review
		listing_review.reviews << Review.new(rating: 4)
		listing_review.save
		listing.num_of_reviews.should eql old_num_of_reviews + 1
	end

	it "Should update parrent listing on save" do
		old_average = listing.rating
		old_length = listing.num_of_reviews
		old_total = listing.listing_review.reviews.inject(0) { |r,e| r + e.rating }

		listing.listing_review.id.should eql the_listing_review.id

		the_listing_review.reviews << Review.new(rating: 4)
		the_listing_review.save

		listing.save
		listing.reload
		listing.rating.should eql ((old_total.to_f + 4) / (old_length + 1)).round(1)
	end

	it "Should tie each reveiw to a user" do
		listing.listing_review.reviews.first.user_id.to_s.should eql users[0].id.to_s
	end

	it "Should have a function to edit a review for a certain user" do
		old_average = listing.rating
		old_total = listing.listing_review.reviews.inject(0) { |r,e| r + e.rating }
		old_length = listing.num_of_reviews

		new_review = 1		
		listing_review = listing.listing_review
		listing_review.update_review( users.last.id, new_review )
		listing_review.save
		listing.save

		listing.reload
		listing.rating.should eql ((11)/(5.to_f)).round(1)
	end

end
