class Review
  include Mongoid::Document
	include Mongoid::Timestamps
  field :rating, type: Integer
	belongs_to :user
	belongs_to :listing_review
end
