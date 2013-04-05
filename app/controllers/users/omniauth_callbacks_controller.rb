class Users::OmniauthCallbacksController < ApplicationController
	def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
			unless @user.not_first_login
				flash[:notice] = "We have Sucsessfully created account and you are now logged in. You can now always login by clicking login with facebook. With your new account you can post on our forum, give respects to pipes of old in our graveyard and rate/comment on strains and dispensaries as well as comment on articles. We will be combining all of these features as user activities increases and we have more data to work with. Please enjoy and have a wonderfull day!"
				@user.not_first_login = true
			else
				flash[:notice] = "Logged in sucsessfully"
			end
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
			flash[:notice] = "Sorry that email is in use. In order to user facebook login you must be signed into a facebook account with an email that is not in our records."
      redirect_to new_user_registration_url
    end

  end

	def twitter
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_oauth(request.env["omniauth.auth"], current_user)
		
    if @user.persisted?
			unless @user.not_first_login
				flash[:notice] = "We have Sucsessfully created account and you are now logged in. You can now always login by clicking login with facebook. With your new account you can post on our forum, give respects to pipes of old in our graveyard and rate/comment on strains and dispensaries as well as comment on articles. We will be combining all of these features as user activities increases and we have more data to work with. Please enjoy and have a wonderfull day!"
				@user.not_first_login = true
			else
				flash[:notice] = "Logged in sucsessfully"
			end
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end

	def failure
		redirect_to "http://www.cannapages.com", notice: "Sorry something went wrong while comunicating with your social media"
	end

end
