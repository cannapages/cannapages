require 'spec_helper'

describe Comment do

	let(:comment) do
		Comment.new body: "They were so awesomly awesome yeah!!!!!",
								rating: 5
	end
	let(:user) do
		FactoryGirl.create(:user)
	end
	let(:listing) do
		FactoryGirl.create(:listing)
	end

	it "Should derive user data on creation" do
		body = "They were so awesome"
		Comment::create listing, user, body
		listing.comments.last.body.should eql body
	end

	it "Should percist in a listing" do
		body = "They were so awesome"
		listing.comments.count.should eql 0
		Comment::create listing, user, body
		listing.reload
		listing.comments.count.should eql 1
	end

	it "Should update a comment based on user and listing" do
		body = "They were so awesome"
		Comment::create listing, user, body
		
		c = listing.comments.last
		body = "They were just alright"
		c.body = body
		Comment::update listing, user, c
		listing.reload
		listing.comments.last.body.should eql body
	end

end
