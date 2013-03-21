class RoachyTipsController < ApplicationController
  def index
		@lessons = RoachyTip.all
    render layout: "business_backend"
  end
  
  def create
  end
  
  def update
  end

  def show
  end

  def new
  end

  def edit
  end
  
  def destroy
  end
end
