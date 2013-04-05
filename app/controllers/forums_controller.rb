class ForumsController < ApplicationController
	before_filter :require_admin, except: [:index,:show]

  def index
		@forums = Forum.all
  end
  
  def create
  end
  
  def update
  end

  def show
		@forum = Forum.find_by( slug: params[:id] )
		@threads = @forum.forum_threads.order_by( created_at: :desc ).to_a
  end

  def new
  end

  def edit
  end
  
  def destroy
  end
end
