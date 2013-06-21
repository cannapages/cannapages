class Comment
  include Mongoid::Document
	include Mongoid::Timestamps
  field :body, type: String
  field :rating, type: Integer

	validates :rating, numericality: { less_than_or_equal_to: 5, greater_than_or_equal_to: 1, only_integer: true }

	belongs_to :commentable, polymorphic: true
	belongs_to :commenter, polymorphic: true
end
