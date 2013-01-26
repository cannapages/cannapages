class Coupon
  include Mongoid::Document
	include Mongoid::Timestamps
  field :deal, type: String
  field :expires, type: Boolean
  field :expiration_date, type: Date

	belongs_to :listing

	class << self
		def search( query )
			(where( deal: (%r[#{query}]i) ).to_a).uniq!
		end
	end

end
