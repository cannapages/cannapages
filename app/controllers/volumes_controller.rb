class VolumesController < ApplicationController
	before_filter :require_admin, except: [:index, :show]

	def admin_index
		@volumes = Volume.all.to_a
		render layout: "admin_backend"
	end

	def edit
		@volume = Volume.find( params[:id] )
		render layout: "admin_backend"
	end

	def update
		@volume = Volume.find( params[:id] )
		@volume.add_to_column( params[:col_num], Article.find_by( slug: params[:article]) )
		if @volume.save
			redirect_to edit_volume_path @volume
		else
			render "edit"
		end
	end
end
