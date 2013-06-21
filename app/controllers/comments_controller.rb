class CommentsController < ApplicationController
	before_filter :require_user
  def new
		load_commentable
		@comment = @commentable.comments.new
  end

  def create
		load_commentable
		@comment = @commentable.comments.create( params[:comment] )
		if @comment.valid?
			@comment.commenter = current_user
			@comment.save
			current_user.comments.select {|c| c.commentable.id == @commentable.id and c.id != @comment.id}.each do |c|
				c.rating = @comment.rating
				c.save
			end
			@commentable.update_rating
			redirect_to @commentable
		else
			redirect_to @commentable, notice: "Sorry we were unable to process your comment"
		end
  end

  def edit
		load_commentable
		@comment = @commentable.comments.find( params[:id] )
  end

  def update
		load_commentable
		@comment = current_user.comments.find( params[:id] )
		@comment.update_attributes( params[:comment] )
		if @comment.valid?
			current_user.comments.select {|c| c.commentable.id == @commentable.id and c.id != @comment.id}.each do |c|
				c.rating = @comment.rating
				c.save
			end
			@commentable.update_rating
			redirect_to @commentable
		else
			redirect_to @commentable, notice: "Sorry we were unable to process your comment"
		end
  end

  def destroy
		load_commentable
		comment = current_user.comments.find( params[:id] )
		comment.destroy if comment
		redirect_to @commentable
  end

	private
	def load_commentable
		resource, id = request.path.split('/')[1,2]
		@commentable = resource.singularize.classify.constantize.find_by(slug: id)
	end
end
