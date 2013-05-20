class ApplicationController < ActionController::Base
  protect_from_forgery

	before_filter :update_user_location, :get_current_user

	def authenticate_for_permision( privilage )
		require_user( privilage ) || redirect_to( root_path, notice: "Sory you don't have the permisions to acsess this page" )
	end

	def require_admin
		require_user( "Admin" )
	end

	def require_business
		require_user( "Business" )
	end

	def require_user( privilage = "Basic" )
		unless current_user and current_user.roles.include? privilage
			redirect_to new_user_registration_path, notice: "You must be logged in to do that. If you don't have an account you can either create one with nothing but an email and password or log in with face book or twitter. We highly value your privacy and will only use your information to create a better experience."
		end
	end

	def require_user_modal( privilage = "Basic" )
		unless current_user and current_user.roles.include? privilage
			redirect_to new_user_session_path, notice: "You must be logged in to do that. If you don't have an account you can either create one with nothing but an email and password or log in with face book or twitter. We highly value your privacy and will only use your information to create a better experience."
		end
	end

	def update_user_location
		if session[:user_location]
			if params["search"] and params["search"]["user_location"] and not params["search"]["user_location"].empty? and (params["search"]["user_location"] != session[:user_location])
				@user_location = UserLocation.new_from_location( params["search"]["user_location"] )
			end
		else
			if params["search"] and params["search"]["user_location"]
				@user_location = UserLocation.new_from_location( params["search"]["user_location"] )
			else
				@user_location = UserLocation.new_from_ip( request.remote_ip )
			end
		end
		@user_location ||= session[:user_location]
		session[:user_location] = @user_location
	end

	def get_current_user
		user_id = session["warden.user.user.key"] 
		@current_user = User.find(user_id[1]) if user_id.class == Array
		unless @current_user.class == User or @current_user.class == NilClass
			@current_user = @current_user.first
		end
	end
	
	def side_banner_front_ads
		@ads = [Ad.one_large.first, Ad.one_small.first].select{|e| not e.nil?}
		@ads.each do |ad|
			ad.shows += 1
			ad.save
		end
	end

end
