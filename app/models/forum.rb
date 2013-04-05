class Forum
  include Mongoid::Document
  field :name, type: String
 	field :slug, type: String
  field :about, type: String
  field :views, type: Integer
 
  has_many :forum_threads
  before_save :initialize_analytics, :update_slug
  
  def initialize_analytics
		self.views = 0
	end

	def update_slug
		self.slug = name.downcase.gsub(' ','-')
	end

	def to_param
		slug
	end

	def num_of_threads
		forum_threads.count
	end

	def num_of_posts
		forum_threads.inject(0) {|r,t| r + t.num_of_posts}
	end

	def latest_post
		latest_post = nil
		forum_threads.each do |thread|
			thread.forum_posts.each do |post|
				if latest_post.class == ForumPost and post.class == ForumPost
					latest_post = post if post.updated_at > latest_post.updated_at
				elsif not latest_post.class == ForumPost and post.class == ForumPost
					latest_post = post
				end
			end
		end
		latest_post.class == ForumPost ? latest_post : "None"
	end

end
