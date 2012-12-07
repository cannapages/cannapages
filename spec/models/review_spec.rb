require 'spec_helper'

describe Review do

	let(:the_review) do
		Review.new rating: 5
	end

	it "Should have a working factory" do
		the_review.save.should be_true
	end

end
