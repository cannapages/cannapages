class ForumThreadsController < ApplicationController
	before_filter :require_user, except: [:index,:show]

  def index
		@forum = Forum.new( name: "Search Results" )
		@threads = ForumThread.all.order_by( updated_at: :desc).to_a
		query = params[:search][:query]
		@threads.select! do |thread|
			content_match = thread.title =~ %r[#{query}]i or thread.forum_posts.where( content: %r[#{query}]i ).count > 0
			author_match = thread.forum_posts.select do |p|
				user = p.user
				user.user_name =~ %r[#{query}]i or user.email =~ %r[query]i
			end
			content_match or not author_match.empty?
		end
		params[:forum_search] = true
  end
  
  def create
		if @forum_thread = ForumThread.create( params[:forum_thread] )
			@forum = Forum.find_by( slug: params[:forum_id] )
			@forum.forum_threads << @forum_thread
			@forum.save
			@post = ForumPost.create( content: params[:forum_thread][:content] )
			@forum_thread.forum_posts << @post
			@forum_thread.user = @current_user
			@post.user = @current_user
			@forum_thread.save
			@post.save
		end
		redirect_to forum_forum_thread_path( @forum, @forum_thread )
  end
  
  def update
		@forum_thread = ForumThread.find_by( slug: params[:id] )
		if @forum_thread.user == @current_user
			@post = @forum_thread.forum_posts.order_by(created_at: :asc).first
			@post.content = params[:forum_thread][:content]
			@forum_thread.update_attributes( params[:forum_thread] )
			@forum_thread.save
			@post.save
			redirect_to forum_forum_thread_path(@forum_thread.forum, @forum_thread)
		else
			redirect_to forum_forum_thread_path(@forum_thread.forum, @forum_thread), notice: "You are not the creator of that thread"
		end
  end

  def show
		@forum = Forum.find_by( slug: params[:forum_id] )
		@thread = ForumThread.find_by( slug: params[:id] )
		unless @current_user == @thread.user
			@thread.views += 1
			@thread.save
		end
		@posts = @thread.forum_posts.order_by( created_at: :decs )
  end

  def new
		@forum_thread = ForumThread.new
  end

  def edit
		@forum_thread = ForumThread.find_by( slug: params[:id] )
		if @forum_thread.user == @current_user
			@post = @forum_thread.forum_posts.order_by(created_at: :asc).first
			debugger
			@forum_thread.content = @post.content
		else
			redirect_to forum_forum_thread_path(@forum_thread.forum, @forum_thread), notice: "You are not the creator of that thread"
		end
  end
  
  def destroy
  end
end
