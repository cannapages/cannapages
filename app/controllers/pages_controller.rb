class PagesController < ApplicationController
	before_filter :require_admin, except: [:show]
	def show
		@page = Page.find_by( slug: params[:id] )
		@page.views += 1
		@page.save
	end

	def index
		@pages = Page.all
		render layout: "admin_backend"
	end

	def edit
		@page = Page.find_by( slug: params[:id] )
		render layout: "admin_backend"
	end

	def update
		@page = Page.find_by( slug: params[:id] )
		@page.update_attributes( params[:page] )
		redirect_to pages_path, notice: "Page updated sucsesfully"
	end
  
end
