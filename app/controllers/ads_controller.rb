class AdsController < ApplicationController
	before_filter :require_admin, except: [:show]

	def show
		@ad = Ad.find( params[:id] )
		@ad.clicks += 1
		@ad.save
		redirect_to ad
	end

  def index
		@ads = Ad.all
		render layout: "admin_backend"
  end

  def new
		@ad = Ad.new
		render layout: "admin_backend"
  end

  def create
		@ad = Ad.create( params[:ad] )
		redirect_to ads_path
  end

  def edit
		@ad = Ad.find( params[:id] )
		render layout: "admin_backend"
  end

  def update
		@ad = Ad.find( params[:id] )
		@ad.update_attributes( params[:ad] )
		redirect_to ads_path
  end

  def destroy
  end
end
