require 'spec_helper'

describe Comment do

	let(:the_comment) do
		Comment.new body: "They were so awesomly awesome yeah!!!!!",
								rating: 5,
								user_name: "Bob420",
								user_email: "bob420@gmail.com"
	end
	let(:the_user) do
		User.new  email: "someone@somewhere.com",
							password: "abcd1234",
							password_confirmation: "abcd1234"
	end

end
