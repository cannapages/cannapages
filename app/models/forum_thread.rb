class ForumThread
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :views, type: Integer
	field :slug, type: String  
	field :has_slug, type: Boolean

	attr_accessor :content

  belongs_to :forum
	belongs_to :user
  has_many :forum_posts
  before_save :update_slug?
	before_create :initialize_analytics

	def to_param
		slug
	end

	def update_slug?
		update_slug unless has_slug
	end
	
	def update_slug
		self.slug = title.downcase.gsub(" ","-")
		same_slugs = ForumThread.where( slug: slug ).count
		if same_slugs > 0
			self.slug += "-#{(same_slugs + 1).to_s}"
		end
		self.has_slug = true
	end

  def initialize_analytics
    self.views = 0
  end
  
	def num_of_posts
		ForumPost.where( forum_thread_id: self.id ).count
	end

end
