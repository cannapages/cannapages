class ApplicationController < ActionController::Base
  protect_from_forgery

	before_filter :update_user_location, :get_current_user

	def authenticate_for_permision( privilage )
		require_user( privilage ) || redirect_to( root_path, notice: "Sory you don't have the permisions to acsess this page" )
	end

	def require_user( privilage )
		current_user and current_user.roles.include? privilage
	end

	def update_user_location
		if session[:user_location]
			if params[:user_location] and params[:user_location] != session[:user_location]
				@user_location = UserLocation.new_from_location( params[:user_location] )
			end
		else
			if params[:user_location]
				@user_location = UserLocation.new_from_location( params[:user_location] )
			else
				@user_location = UserLocation.new_from_ip( request.remote_ip )
			end
		end
		@user_location ||= session[:user_location]
		session[:user_location] = @user_location
	end

	def get_current_user
		@current_user = User.find(session["warden.user.user.key"][1])
		unless @current_user.class == User or @current_user.class == NilClass
			@current_user = @current_user.first
		end
	end

end
