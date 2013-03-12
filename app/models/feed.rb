class Feed
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :uri, type: String
  field :articles_fetched, type: Integer
  field :failures, type: Integer

	before_create :initialize_anylitics, :insure_feed_quality

	def initialize_anylitics
		self.articles_fetched, self.failures = 0, 0
	end

	#Insures feed supplies nessisary data
	def insure_feed_quality
		feed = Feedzirra::Feed.fetch_and_parse( uri )
		test_entry = feed.entries.first
		feed_meets_cpi_standards = true
		needed_attributes = []
		[:title,:url,:author,:content,:published,:categories].each do |message|
			value = test_entry.send(message)
			if( value.nil? or ((value.class == String and value.empty?) or value.class != String ))
				feed_meets_cpi_standards = false
				needed_attributes << message
			end
		end
		unless feed_meets_cpi_standards
			self.errors.messages[:feed_format] = "Feed needs to offer all required. Missing #{needed_attributes}"
		end
		feed_meets_cpi_standards
	end
	
end
