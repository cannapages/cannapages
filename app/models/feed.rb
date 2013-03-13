class Feed
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :uri, type: String
  field :articles_fetched, type: Integer
  field :failures, type: Integer
	field :features, type: Array

	before_create :initialize_anylitics, :insure_feed_quality

	def update_articles_for_feed
		feed = fetch_feed
		feed.entries.each do |e|
			a = Article.new
			self.features.each do |message|
				a.send( (message.to_s + "=").to_sym, e.send(message) )
			end
			if a.save
				self.articles_fetched += 1
			end
		end
		self.save
	end

	def fetch_feed_without_save
		feed = Feedzirra::Feed.fetch_and_parse( self.uri )
		if feed.class == Integer
			self.failures += 1
			[]
		else
			feed
		end
	end

	def fetch_feed
		feed = fetch_feed_without_save
		self.save
		feed
	end

	def initialize_anylitics
		self.articles_fetched, self.failures = 0, 0
	end

	#Insures feed supplies nessisary data
	def insure_feed_quality
		feed = fetch_feed_without_save
		test_entry = feed.entries.first
		feed_meets_cpi_standards = true
		needed_attributes = []
		[:title,:url,:content].each do |message|
			value = test_entry.send(message)
			unless value
				feed_meets_cpi_standards = false
				needed_attributes << message
			end
		end
		unless feed_meets_cpi_standards
			self.errors.messages[:feed_format] = "Feed needs to offer all required attributes. Missing #{needed_attributes}"
		end
		track_feed_supplied_elements( test_entry )
		feed_meets_cpi_standards
	end

	def track_feed_supplied_elements( test_entry )
		supplied_attributes = []
		[:title,:url,:author,:content,:published,:categories].each do |message|
			value = test_entry.send(message)
			if value
				supplied_attributes << message
			end
		end
		self.features = supplied_attributes
	end

	class << self
		def update_articles
			each do |feed|
				feed.update_articles_for_feed
			end
		end
	end
	
end
