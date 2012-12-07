class Review
  include Mongoid::Document
  field :rating, type: Integer
	belongs_to :listing_review
end
