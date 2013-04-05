class CritiquesController < ApplicationController

	before_filter :require_admin, except: [:index, :show, :home]

	def admin_index
		@critiques = Critique.all.order_by( updated_at: :asc ).to_a
		render layout: "admin_backend"
	end

	def home
		@critiques = Critique.all.order_by(updated_at: :desc).limit(8).to_a
		@latest = @critiques.first
		@critiques -= [@latest]
		@listings = Listing.all.to_a.select{|e| not e.critique_ids.empty?}
		@strains = Strain.all.to_a.select{|e| not e.critique_ids.empty?}
	end

  def index
		if params[:listing]
			@listing = Listing.where( slug: params[:listing] ).first
			@critiques = @listing.critiques
			if @critiques.size == 1
				@critique = @critiques.first
				@strain_test = @critique.strain_test
				@strain = @critique.strain
				render "show"
			end
		elsif params[:search] and params[:search][:query]
			reg = %r[#{params[:search][:query]}]i
			@critiques = Critique.any_of( title: reg ).any_of( content: reg ).to_a
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
		Critique.find_by( slug: params[:id] ).destroy
		redirect_to critiques_admin_index_path
  end

	private

	def get_collection_data
		@listings = Listing.order_by( name: :asc ).all
		@strain_tests =  StrainTest.order_by( slug: :asc ).all
		@strains = Strain.order_by( name: :asc ).all
	end
end
