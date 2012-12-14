class Comment
  include Mongoid::Document
	include Mongoid::Timestamps
  field :body, type: String
  field :user_name, type: String
  field :user_email, type: String
	field :user_id, type: String
	embedded_in :listing

	class << self
		def create listing, user, body
			c = Comment.new( body: body, user_name: user.user_name, user_email: user.email,
												user_id: user.id )
			listing.comments << c
		end

		def update listing, user, comment
			c = listing.comments.where(user_id: user.id).find( comment.id )
			c.body = comment.body
			listing.save
		end

	end
end
