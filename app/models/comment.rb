class Comment
  include Mongoid::Document
	include Mongoid::Timestamps
  field :body, type: String
  field :rating, type: Integer
  field :user_name, type: String
  field :user_email, type: String
	embedded_in :listing
	embedded_in :user
end
