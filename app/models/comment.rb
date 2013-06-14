class Comment
  include Mongoid::Document
	include Mongoid::Timestamps
  field :body, type: String
	attr_accessor :rating
	belongs_to :commentable, polymorphic: true
	belongs_to :commenter, polymorphic: true
end
