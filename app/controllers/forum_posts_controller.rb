class ForumPostsController < ApplicationController
	before_filter :require_user

  def create
		@thread = ForumThread.find_by( slug: params[:forum_thread_id] )
		@post = ForumPost.create( params[:forum_post] )
		@thread.forum_posts << @post
		@thread.save
		@post.user = @current_user
		@post.save
		redirect_to forum_forum_thread_path( params[:forum_id], params[:forum_thread_id] )
  end
  
  def new
		@forum_post = ForumPost.new
  end

  def edit
		@forum_post = ForumPost.find( params[:id] )
  end

  def update
		@thread = ForumThread.find_by( slug: params[:forum_thread_id] )
		@post = ForumPost.find( params[:id] )
		@post.update_attributes( params[:forum_post] )
		@thread.save
		@post.save
		redirect_to forum_forum_thread_path( params[:forum_id], params[:forum_thread_id] )
  end
  
  def destroy
		@post = ForumPost.find( params[:id] )
		@thread = ForumThread.find_by( slug: params[:forum_thread_id] )
		unless @thread.forum_posts.order_by( created_at: :asc ).first == @post
			@post.destroy
		else
			redirect_to forum_forum_thread_path( params[:forum_id], params[:forum_thread_id] ), notice: "Sory you can't remove the main thread post you can edit it if its yours though."
			return
		end
		redirect_to forum_forum_thread_path( params[:forum_id], params[:forum_thread_id] )
  end

end
