class ListingReview
  include Mongoid::Document

	has_many :reviews

	def average_rating
		total = reviews.inject(0) { |sum,e| e.rating + sum }
		average = (total.to_f/(reviews.size)).round(1)
	end

end
