class Article
  include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Paperclip
  field :title, type: String
	field :slug, type: String
	field :url, type: String
	field :author, type: String
  field :content, type: String
  field :published, type: String
  field :categories, type: String
  field :views, type: Integer
  field :likes, type: Integer
	field :cannapages_exclusive, type: Boolean
  has_mongoid_attached_file :article_image, :styles => { :large => "500x500#", :thumb => "150x150#" }

	validates_uniqueness_of :url

	before_create :initialize_anylitics, :add_image_if_possible
	before_save :remove_unwanted_html_tags, :update_slug, :find_and_remove_footer

	def to_param
		slug
	end

	def add_image_if_possible
		doc = Nokogiri::HTML(content)
		image_url = doc.css('img').first.attributes["src"].value if doc.css('img').first
		self.article_image = open(image_url) if image_url
	end

	def find_and_remove_footer
		doc = Nokogiri::HTML(content)
		while (doc.css('a').last and doc.css('a').last.attributes["href"].value =~ /feedburner/)
			doc.css('a').last.remove
			puts "1 tier executed"
		end
		self.content = doc.to_s
	end

	def update_slug
		self.slug = title.downcase.gsub(/\W/,'')
	end

	def initialize_anylitics
		self.views, self.likes = 0,0
	end

	def remove_unwanted_html_tags
		self.content = Sanitize.clean( content, Sanitize::Config::RELAXED)
	end

	def exerpt( words = 30 )
		Sanitize.clean(HTML_Truncator.truncate(content, words), Sanitize::Config::BASIC)
	end

	class << self
		def search( query )
			(where( title: (%r[#{query}]i) ).to_a + where( content: (%r[#{query}]i) ).to_a).uniq!
		end
	end
end
