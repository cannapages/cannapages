class Review
  include Mongoid::Document
	include Mongoid::Timestamps
	field :rating, type: Integer
	belongs_to :user
	belongs_to :reviewable, polymorphic: true
	has_many :comments, as: :commenter
	validates_presence_of :rating
end
