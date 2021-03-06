class Critique
  include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Paperclip

  field :title, type: String
  field :content, type: String
  field :views, type: Integer
  field :likes, type: Integer
	field :slug, type: String

	has_many :comments
	belongs_to :listing
	belongs_to :user
	belongs_to :strain_test
	belongs_to :strain
  has_mongoid_attached_file :critique_image, :styles => { :large => "300x300#", :small => "150x150#" }

	before_save :initialize_anylitics, :remove_unwanted_html_tags, :update_slug

	def update_slug
		self.slug = title.downcase.gsub(" ","-")
	end

	def initialize_anylitics
		self.views, self.likes = 0,0
	end

	def remove_unwanted_html_tags
		self.content = Sanitize.clean( content, Sanitize::Config::RELAXED)
	end

	def index_title
		parts = title.split("from")
		if parts.size > 1
			parts.first.strip
		else
			title[0..10] + "..."
		end
	end

	def exerpt( words = 30 )
		HTML_Truncator.truncate(content, words)
	end

	def to_param
		slug
	end

	class << self
		def search( query )
			(where( title: (%r[#{query}]i) ).to_a + where( content: (%r[#{query}]i) ).to_a).uniq!
		end
	end

end
