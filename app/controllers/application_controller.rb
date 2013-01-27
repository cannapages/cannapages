class ApplicationController < ActionController::Base
  protect_from_forgery

	def authenticate_for_permision( privilage )
		require_user( privilage ) || redirect_to( root_path, notice: "Sory you don't have the permisions to acsess this page" )
	end

	def require_user( privilage )
		current_user and current_user.roles.include? privilage
	end

end
