class StrainsController < ApplicationController
	before_filter :require_admin, except: [:index,:show]

	def admin_index
		@strains = Strain.all.order_by(name: :asc).to_a
		render layout: "admin_backend"
	end

  def index
		@strains = Strain.all.order_by(name: :asc).to_a
  end
  
  def create
  end
  
  def update
  end

  def show
		@strain = Strain.where( slug: params[:id] ).first
		@strain_tests = @strain.strain_tests.to_a
  end

  def new
  end

  def edit
  end
  
  def destroy
  end
end
