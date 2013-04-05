class ReviewsController < ApplicationController
	before_filter :require_user
  def new
		@listing = Listing.find_by( slug: params[:id] )
		@review = Review.new
  end

  def edit
		@listing = Listing.find_by( slug: params[:listing_id] )
		@comment = Comment.find( params[:id] )
		@review = @comment.review
  end

  def create
		@listing = Listing.find_by( slug: params[:id] )
		comment = params[:review][:comment]
		params[:review].remove!(:comment)
		@review = Review.new( params[:review] )
		if @review.valid?
			@old_review = @listing.listing_review.reviews.select{|r| r.user == current_user}.first
			unless @old_review
				@listing.listing_review.reviews << @review
				@current_user.reviews << @review
			else
				@old_review.rating = @review.rating
				@old_review.save
				@review = @old_review
			end
			if comment and not comment.empty?
				@comment = @listing.comments.build( body: comment )
				@current_user.comments << @comment
				@review.comments << @comment
				@listing.comments << @comment
			end
			@listing.save
			@review.save
			@current_user.save
			@comment.save
		else
			render "new"
		end
		redirect_to @listing
  end

  def update
		@listing = Listing.find_by( slug: params[:listing_id] )
		@comment = @current_user.comments.find( params[:id] )
		@review = @comment.review
		@comment.body = params[:comment][:body]
		@review.rating = params[:comment][:rating] if params[:comment][:rating]
		@comment.save
		@review.save
		redirect_to @listing
  end

	def destroy
		@comment = @current_user.comments.find( params[:id] )
		@review = @comment.review
		@review.destroy unless @review.comments.size > 1
		@comment.destroy
		redirect_to Listing.find_by( slug: params[:listing_id] )
	end

end
