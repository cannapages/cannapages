class ArticlesController < ApplicationController
	before_filter :require_admin, except: [:index, :show]

	def admin_index
		@articles = Article.all.order_by( title: :asc ).to_a
		render layout: "admin_backend"
	end

  def index
		@articles = Article.all.sort_by( created_at: :desc ).to_a
  end
  
  def create
		@article = Article.new( params[:article] )
		if @article.save
			redirect_to articles_admin_index_path
		else
			render "new", layout: "admin_backend"
		end
  end
  
  def update
		@article = Article.find_by( slug: params[:id] )
		if @article.update_attributes( params[:article] )
			redirect_to articles_admin_index_path
		else
			render "edit", layout: "admin_backend"
		end
  end

  def show
		@article = Article.find_by( slug: params[:id] )
  end

  def new
		@article = Article.new
		render layout: "admin_backend"
  end

  def edit
		@article = Article.find_by( slug: params[:id] )
		render layout: "admin_backend"
  end
  
  def destroy
		Article.find_by( slug: params[:id] ).destroy
		redirect_to articles_admin_index_path
  end

end
