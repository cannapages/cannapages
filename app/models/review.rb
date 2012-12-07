class Review
  include Mongoid::Document
  field :rating, type: Integer
	embedded_in :listing_review
end
