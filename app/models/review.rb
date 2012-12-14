class Review
  include Mongoid::Document
  field :rating, type: Integer
  field :user_id, type: String
	embedded_in :listing_review
end
