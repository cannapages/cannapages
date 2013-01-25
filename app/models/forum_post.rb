class ForumPost
  include Mongoid::Document
  include Mongoid::Timestamps
  field :content, type: String
  
  embedded_in :thread
  belongs_to :user
  before_save :remove_unwanted_html_tags
  
	def remove_unwanted_html_tags
		self.content = Sanitize.clean( content, Sanitize::Config::RELAXED)
	end
end
