class ListingReview
  include Mongoid::Document
	include Mongoid::Timestamps

	has_many :reviews
	belongs_to :listing

	def average_rating
		return 0 if reviews.size < 1
		total = reviews.inject(0) { |sum,e| e.rating + sum }
		average = (total.to_f/(reviews.size)).round(1)
	end

	before_save :update_average

	def update_average
		self.listing.rating = average_rating.round(0)
		self.listing.num_of_reviews = reviews.size
	end

end
