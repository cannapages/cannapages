class ArticlesController < ApplicationController
	before_filter :require_admin, except: [:index, :show]

	def admin_index
		@articles = Article.all.order_by( title: :asc ).to_a
		render layout: "admin_backend"
	end

  def index
		if params[:search] and params[:search][:query]
			reg = %r[#{params[:search][:query]}]i
			@articles = Article.any_of( title: reg ).any_of( content: reg).any_of( categories: reg ).any_of( author: reg ).order_by( created_at: :decs ).to_a 
		else
			@articles = Article.all.order_by( created_at: :desc ).to_a
		end
		@articles = Kaminari.paginate_array(@articles).page(params[:page]).per(25)
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
