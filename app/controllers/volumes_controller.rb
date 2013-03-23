class VolumesController < ApplicationController
	before_filter :require_admin, except: [:index, :show]

	def admin_index
		@volumes = Volume.all.order_by( volume_number: :asc ).to_a
		render layout: "admin_backend"
	end

	def edit
		@volume = Volume.find_by( volume_number: params[:id] )
		@articles = Article.all.order_by(title: :asc).to_a
		@three_col_array = @volume.get_3_col_array
		@max_array_size = 0
		@three_col_array.map do |e|
			@max_array_size = e.size if e.size > @max_array_size
		end
		render layout: "admin_backend"
	end

	def update
		@volume = Volume.find_by( volume_number: params[:id] )
		@volume.add_to_column( params[:col_num], Article.find_by( slug: params[:article]) )
		if @volume.save
			redirect_to edit_volume_path @volume
		else
			render "edit", layout: "admin_backend"
		end
	end

	def move_element
		@volume = Volume.find_by( volume_number: params[:id] )
		@volume.move_element( params[:col_num], params[:index], params[:delta] )
		@volume.save
		redirect_to edit_volume_path @volume
	end

	def remove_element
		@volume = Volume.find_by( volume_number: params[:id] )
		@volume.remove_from_column( params[:col_num], params[:index] )
		@volume.save
		redirect_to edit_volume_path @volume
	end

	def add_articles
		@volume = Volume.find_by(volume_number: params[:id])
		unless params[:article1_slug] == "nil"
			@article1 = Article.find_by( slug: params[:article1_slug] )
			@volume.add_to_column(1,@article1)
		end
		unless params[:article2_slug] == "nil"
			@article2 = Article.find_by( slug: params[:article1_slug] )
			@volume.add_to_column(2,@article2)
		end
		unless params[:article3_slug] == "nil"
			@article3 = Article.find_by( slug: params[:article3_slug] )
			@volume.add_to_column(3,@article3)
		end
		@volume.save
		redirect_to edit_volume_path(@volume)
	end

	def create
		Volume.create
		redirect_to volumes_admin_index_path
	end

	def destroy
		@volume = Volume.find_by( volume_number: params[:id] )
		redirect_to volumes_admin_index_path
	end
end
