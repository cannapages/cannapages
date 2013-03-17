class StrainsController < ApplicationController
  def index
		@strain = Strain.all
  end
  
  def create
  end
  
  def update
  end

  def show
		@strain = Strain.where( slug: params[:id] ).first
  end

  def new
  end

  def edit
  end
  
  def destroy
  end
end
