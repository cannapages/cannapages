require 'spec_helper'

describe Comment do

	let(:the_comment) do
		Comment.new body: "They were so awesomly awesome yeah!!!!!",
								rating: 5,
								user_name: "Bob420",
								user_email: "bob420@gmail.com"
	end

	it "Should have a working a factory" do
		the_comment.save.should be_true
	end

end
