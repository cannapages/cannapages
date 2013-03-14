class ApplicationController < ActionController::Base
  protect_from_forgery

	before_filter :update_user_location

	def authenticate_for_permision( privilage )
		require_user( privilage ) || redirect_to( root_path, notice: "Sory you don't have the permisions to acsess this page" )
	end

	def require_user( privilage )
		current_user and current_user.roles.include? privilage
	end

	def update_user_location
		if session[:user_location].nil? and params[:user_location].nil?
			@user_location = UserLocation.new_from_ip( request.remote_ip )
		elsif session[:user_location].nil? and params[:user_location]
			@user_location = UserLocation.new_from_location( params[:user_location] )
		elsif session[:user_location] and params[:user_location] != session[:user_location]
			@user_location = UserLocation.new_from_location( params[:user_location] )
		elsif session[:user_location] and params[:user_location] == session[:user_location]
			return
		end
		session[:user_location] == @user_location
	end

end
