class ListingReview
  include Mongoid::Document

	embeds_many :reviews
	belongs_to :listing

	def average_rating
		total = reviews.inject(0) { |sum,e| e.rating + sum }
		average = (total.to_f/(reviews.size)).round(1)
	end

end
