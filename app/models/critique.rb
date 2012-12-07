class Critique
  include Mongoid::Document
	include Mongoid::Timestamps
  field :title, type: String
  field :content, type: String
  field :views, type: Integer
  field :likes, type: Integer

	before_save :initialize_anylitics, :remove_unwanted_html_tags

	def initialize_anylitics
		self.views, self.likes = 0,0
	end

	def remove_unwanted_html_tags
		self.content = Sanitize.clean( content, Sanitize::Config::RELAXED)
	end

end
