class RssFeedsController < ApplicationController
	before_filter :require_admin

  def admin_index
		@feeds = Feed.all.to_a
		render layout: "admin_backend"
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
