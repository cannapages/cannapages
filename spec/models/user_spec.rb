require 'spec_helper'
require 'models/helpers'

describe User do

	let(:the_user) do
		User.new  email: "someone@somewhere.com",
							password: "abcd1234",
							password_confirmation: "abcd1234"
	end

	it "Should percist with basic settings" do
		the_user.save.should be_true
	end

	it "Should only except valid email settings" do
		the_user.email = "invalidemail"
		the_user.should be_invalid
	end

	it "Should require password to have at least 8 characters" do
		the_user.password = "abc1234"
		the_user.password_confirmation = "abc1234"
		the_user.should be_invalid
	end

	it "Should need characters and numbers" do
		the_user.password = "abcdefghiasdf"
		the_user.password_confirmation = "abcdefghiasdf"
		the_user.should be_invalid
	end

	it "Should force password and password_confirmation match" do
		the_user.password = "abcdef123"
		the_user.should be_invalid
	end

end
