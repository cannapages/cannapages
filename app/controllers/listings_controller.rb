class ListingsController < ApplicationController
  def index
  end
  
  def create
  end
  
  def update
  end

  def show
		params[:intent] ||= "cannawisdom"
		view = params[:intent]
		@listing = Listing.where( slug: params[:id] ).first
		render view, layout: "listing_show"
  end

  def new
		@listing = Listing.new
    render layout: "business_backend"
  end

  def edit
		@listing = @current_user.listing
    render layout: "business_backend"
  end
  
  def destroy
    render layout: "business_backend"
  end

  def admin_index
  end

  def admin_edit
  end

  def admin_new
  end
  
  def admin_update
  end
  
  def admin_create
  end
end
