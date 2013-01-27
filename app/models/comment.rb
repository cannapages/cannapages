class Comment
  include Mongoid::Document
	include Mongoid::Timestamps
  field :body, type: String
  field :user_name, type: String
  field :user_email, type: String
	field :user_id, type: String
	embedded_in :listing
	embedded_in :article
	embedded_in :critique
	embedded_in :strain
end
