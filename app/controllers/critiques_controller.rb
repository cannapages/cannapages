class CritiquesController < ApplicationController
  def index
		if params[:listing]
			listing = Listing.where( slug: params[:listing] ).first
			@critiques = listing.critiques
			if @critiques.size == 1
				@critique = @critiques.first
				render "show"
			end
		elsif params[:q]
			@critiques = Critique.all
		else
			@critiques = Critique.all
		end
  end

  def new
		get_collection_data
		@critique = Critique.new
		render layout: "admin_backend"
  end
  
  def create
		@critique = Critique.new( params[:critique] )
		@critique.strain ||= @critique.strain_test.strain if @critique.strain_test
		if @critique.save
			redirect_to new_critique_path
		else
			get_collection_data
			render "new"
		end
  end
  
  def update
		@critique = Critique.find( params[:id] )
		@critique.strain ||= @critique.strain_test.strain
		if @critique.update_attributes( params[:critique] )
			redirect_to new_critique_path
		else
			get_collection_data
			render "edit"
		end
  end

  def show
		@critique = Critique.where( slug: params[:id] ).first
		@listing = @critique.listing
    @strain_test = @critique.strain_test
		@strain = @critique.strain
  end


  def edit
		get_collection_data
		@critique = Critique.find(params[:id])
		render layout: "admin_backend"
  end
  
  def destroy
  end

	private

	def get_collection_data
		@listings = Listing.order_by( name: :asc ).all
		@strain_tests =  StrainTest.order_by( slug: :asc ).all
		@strains = Strain.order_by( name: :asc ).all
	end
end
