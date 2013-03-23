class Users::OmniauthCallbacksController < ApplicationController
	def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
			flash[:notice] = "Sucsessfully created account you are now logged int"
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

	def twitter
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_oauth(request.env["omniauth.auth"], current_user)
		
		debugger
    if @user.persisted?
			flash[:notice] = "Sucsessfully created account you are now logged in"
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end

	def failure
		redirect_to "http://www.cannapages.com", notice: "Sorry something went wrong while comunicating with facebook"
	end

end
