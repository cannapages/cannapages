class FeedsController < ApplicationController
	before_filter :require_admin

  def admin_index
		@feeds = Feed.all.to_a
		render layout: "admin_backend"
  end
  
  def create
		@feed = Feed.new( params[:feed] )
		if @feed.save
			redirect_to feeds_admin_index_path, notice: "Feed created sucsessfully"
		else
			render "new", layout: "admin_backend"
		end
  end
  
  def update
		@feed = Feed.find( params[:id] )
		if @feed.update_attributes( params[:feed] )
			redirect_to feeds_admin_index_path, notice: "Feed updated Sucsessfully"
		else
			render "edit", layout: "admin_backend"
		end
  end

  def new
		@feed = Feed.new
		render layout: "admin_backend"
  end

  def edit
		@feed = Feed.find( params[:id] )
		render layout: "admin_backend"
  end
  
  def destroy
		Feed.find( params[:id] ).destroy
		redirect_to feeds_admin_index_path, notice: "Feed was removed from database"
  end
 
	def fetch_articles
		old_article_count = Article.count
		Feed.update_articles
		new_article_count = Article.count
		redirect_to feeds_admin_index_path, notice: "#{new_article_count - old_article_count} articles fetched"
	end
 
end
