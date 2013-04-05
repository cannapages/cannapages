class Comment
  include Mongoid::Document
	include Mongoid::Timestamps
  field :body, type: String
	attr_accessor :rating
	belongs_to :listing
	belongs_to :user
	belongs_to :review
end
