class Article
  include Mongoid::Document
	include Mongoid::Timestamps
	field :soul_id, type: String
  field :title, type: String
  field :content, type: String
  field :views, type: Integer
  field :likes, type: Integer

	before_create :initialize_anylitics
	before_save :remove_unwanted_html_tags

	def initialize_anylitics
		self.views, self.likes = 0,0
	end

	def remove_unwanted_html_tags
		self.content = Sanitize.clean( content, Sanitize::Config::RELAXED)
	end

	class << self
		def search( query )
			(where( title: (%r[#{query}]i) ).to_a + where( content: (%r[#{query}]i) ).to_a).uniq!
		end
	end
end
