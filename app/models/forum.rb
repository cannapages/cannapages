class Forum
  include Mongoid::Document
  field :name, type: String
  field :about, type: String
  field :views, type: Integer
  
  embeds_many :forum_threads
  before_save :initialize_analytics
  
  def initialize_analytics
		self.views = 0
	end
end
