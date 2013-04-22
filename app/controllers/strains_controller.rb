class StrainsController < ApplicationController
	before_filter :require_admin, except: [:index,:show]

	def admin_index
		@strains = Strain.all.order_by(name: :asc).to_a
		render layout: "admin_backend"
	end

  def index
		query = params[:search][:query] if params[:search] and params[:search][:query]
		if query
			@strains_with_name = Strain.where(name: %r[#{query}]i).order_by(name: :asc).to_a
			@other_matches = Strain.any_of( dominance: %r[#{query}]i ).
												any_of( menu_type: %r[#{query}]i).any_of( origins: %r[#{query}]i ).
												any_of(	flowering_time: %r[#{query}]i).any_of( bio: %r[#{query}]i ).
												any_of(	genetics: %r[#{query}]i ).order_by(name: :asc).to_a
			@strains = @strains_with_name + @other_matches
		else
			@strains = Strain.all.order_by(name: :asc).to_a
		end
		@strains = Kaminari.paginate_array(@strains).page(params[:page]).per(25)
		@ads = side_banner_front_ads
  end
  
  def create
		@strain = Strain.new( params[:strain] )
		if @strain.save
			render "new", notice: "The system was not able to create a strain with those paramiters"
		else
			redirect_to strains_admin_index_path, notice: "The system was not able to create a strain with those paramiters"
		end
  end
  
  def update
		Strain.find_by(slug: params[:id]).update_attributes( params[:strain] )
		redirect_to strains_admin_index_path, notice: "Updated Strain"
  end

  def show
		@strain = Strain.where( slug: params[:id] ).first
		@strain_tests = @strain.strain_tests.to_a
		@ads = side_banner_front_ads
  end

  def new
		@strain = Strain.new
		render layout: "admin_backend"
  end

  def edit
		@strain = Strain.find_by( slug: params[:id] )
		render layout: "admin_backend"
  end
  
  def destroy
		@strain = Strain.find_by( slug: params[:id] ).destroy
		redirect_to strains_admin_index_path, notice: "Strain has been elemenitated sire! Muhhahaha"
  end

end
