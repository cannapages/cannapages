class UsersController < ApplicationController
  def edit
		render layout: "users_backend"
  end

  def update
		if params[:user][:user_name]
			@current_user.user_name = params[:user][:user_name]
		end
		if params[:user][:password] and params[:user][:password_confirmation]
			@current_user.password = params[:user][:password]
			@current_user.password_confirmation = params[:user][:password_confirmation]
		end
		@current_user.save
		redirect_to user_account_edit_path
  end
end
