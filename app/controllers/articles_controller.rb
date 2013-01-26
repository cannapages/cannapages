class ArticlesController < ApplicationController
  def index
		@articles = @article.search( params[:search] )
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
