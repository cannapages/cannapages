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

	def require_user( privilage )
		current_user and current_user.roles.include? privilage
	end

	def format_time_params( root_key )
		if params[root_key]
			time_params = params[root_key].select do |key,value|
				key =~ /\(..\)/
			end
			time_params.keys.each do |key|
				params[root_key].remove!(key)
			end
			initial_key = true
			while initial_key
				if time_params.first
					initial_key = time_params.first.first
				else
					initial_key = nil
					next
				end
				main_key = initial_key.gsub(/\(..\)/,'')
				time_attr_keys = []
				5.times do |i|
					time_attr_keys << "#{main_key}(#{i+1}i)"
				end
				main_value = Time.new(time_attr_keys[0].to_i,time_attr_keys[2].to_i,time_attr_keys[1].to_i,time_attr_keys[3].to_i,time_attr_keys[4].to_i)
				params[root_key][main_key] = main_value.to_s
				time_attr_keys.each do |key|
					time_params.remove!(key)
				end
			end
		end
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
		user_id = session["warden.user.user.key"] 
		@current_user = User.find(user_id[1]) if user_id.class == Array
		unless @current_user.class == User or @current_user.class == NilClass
			@current_user = @current_user.first
		end
	end

end
