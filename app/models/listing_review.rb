class ListingReview
  include Mongoid::Document
	include Mongoid::Timestamps

	embeds_many :reviews
	belongs_to :listing
	belongs_to :user

	def average_rating
		return -1 if reviews.size < 1
		total = reviews.inject(0) { |sum,e| e.rating + sum }
		average = (total.to_f/(reviews.size)).round(1)
	end

	before_save :update_average

	def update_average
		self.listing.rating = average_rating.round(1)
		self.listing.num_of_reviews = reviews.size
	end

	def update_review user_id, new_rating
		old_review = reviews.where( user_id: user_id ).first
		old_review.rating = new_rating
		save
	end

end
