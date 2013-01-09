class Review
  include Mongoid::Document
	include Mongoid::Timestamps
  field :rating, type: Integer
  field :user_id, type: String
	embedded_in :listing_review
end
