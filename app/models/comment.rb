class Comment
  include Mongoid::Document
	include Mongoid::Timestamps
  field :body, type: String
  field :user_name, type: String
  field :user_email, type: String
	field :user_id, type: String
	belongs_to :critique
end
