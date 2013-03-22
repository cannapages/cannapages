class PhotoUploadsController < ApplicationController
	before_filter :require_business
	def new
		@listing = current_user.listings.first
		@photo_upload = PhotoUpload.new
		render layout: "business_backend"
	end
	def create
		@photo_upload = PhotoUpload.new( params[:photo_upload] )
		@listing = current_user.listings.first
		if @photo_upload.save
			@listing.photo_uploads << @photo_upload
			redirect_to new_photo_upload_path
		else
			render "new"
		end
	end
end
