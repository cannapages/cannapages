class ArticlesController < ApplicationController
	before_filter :require_admin, except: [:index, :show]

	def admin_index
		@articles = Article.all.order_by( title: :asc ).to_a
		render layout: "admin_backend"
	end

  def index
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
