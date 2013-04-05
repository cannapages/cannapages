class PipeGravesController < ApplicationController
	before_filter :require_user
	def index
		@pipe_graves = @current_user.pipe_graves
		render layout: "users_backend"
	end

  def new
		@pipe_grave = PipeGrave.new
  end

	def create
		@pipe_grave = PipeGrave.new( params[:pipe_grave] )
		@pipe_grave.user = @current_user
		@pipe_grave.save
		redirect_to pipe_graves_path
	end

  def edit
		@pipe_grave = @current_user.pipe_graves.find( params[:id] )
  end

	def destroy
		@current_user.pipe_graves.find( params[:id] ).destroy
		redirect_to pipe_graves_path
	end
end
