class Forum
  include Mongoid::Document
  field :name, type: String
  field :about, type: String
  field :views, type: Integer
  
  embeds_many :threads
  before_save :initialize_analytics
  
  def initialize_anylitics
		self.views = 0
	end
end
