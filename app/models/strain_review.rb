class StrainReview
  include Mongoid::Document
	include Mongoid::Timestamps

	has_many :reviews, as: :reviewable
	belongs_to :strain

	def average_rating
		return 0 if reviews.size < 1
		total = reviews.inject(0) { |sum,e| e.rating + sum }
		average = (total.to_f/(reviews.size)).round(1)
	end

	before_save :update_average

	def update_average
		self.strain.rating = average_rating.round(0)
		self.strain.num_of_reviews = reviews.size
	end

end
