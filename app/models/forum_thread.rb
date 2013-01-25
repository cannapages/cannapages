class ForumThread
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :views, type: Integer
  
  embedded_in :forum
  embeds_many :posts
  belongs_to :user
  before_save :initialize_analytics
  before_save :remove_unwanted_html_tags
  
  def initialize_analytics
    self.views = 0
  end
  
  def remove_unwanted_html_tags
		self.content = Sanitize.clean( content, Sanitize::Config::RELAXED)
	end
end
