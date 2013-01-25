class Listing
	#Modules
  include Mongoid::Document
	include Mongoid::Timestamps

	#Fields
	#Info
  field :name, type: String
	field :about, type: String
  field :phone, type: String
  field :street_address, type: String
  field :city, type: String
  field :state, type: String
  field :zip, type: String
  field :lat, type: Float
  field :lng, type: Float
	field :website, type: String
	field :twitter, type: String
	field :facebook, type: String
	#Service types
  field :category, type: String
	field :match_coupons, type: Boolean
	field :glass_sale, type: Boolean
	field :whole_sale, type: Boolean
	#Account
	field :featured, type: Boolean
	field :featured_expiration, type: Date
	#Anylitics
	field :shows, type: Integer
	field :clicks, type: Integer
	field :featured_shows, type: Integer
	field :featured_clicks, type: Integer
	#Ratings
	field :rating, type: Float
	field :num_of_reviews, type: Integer
	#Relations
	field :live_menu_id, type: String
	
	#Validations
	validates_inclusion_of :state, allow_nil: false, in: LEGAL_STATE_ARRAY
	validates_inclusion_of :category, allow_nil: false, in: LISTING_CATEGORY_ARRAY

	#Relations
	has_one :listing_review, autobuild: true, autosave: true
	has_one :live_menu, autobuild: true
	embeds_many :comments

	#Callbacks
	before_save :initialize_anylitics, :format_phone, :update_lat_lng?, :ensure_http
	before_create :initialize_dependencies

	def initialize_dependencies
		create_listing_review unless listing_review
		self.rating = listing_review.average_rating
		
		create_live_menu unless live_menu
	end

	def initialize_anylitics
		self.shows, self.clicks, self.featured_shows, self.featured_clicks, self.num_of_reviews = 0,0,0,0,0
	end

	def format_phone
		phone.gsub!(/[^0-9]/, "")
		length = phone.length
		self.phone = phone[(length - 10)..length] if length > 10
	end

	def update_lat_lng?
		update_lat_lng if street_address_changed? or city_changed? or state_changed? or zip_changed?
	end

	def update_lat_lng
		geo = Geokit::Geocoders::GoogleGeocoder.geocode self.full_address
		self.lat = geo.lat
		self.lng = geo.lng	
	end

	def ensure_http
		[ :website, :facebook, :twitter ].each do |attr|
			if self.send(attr)
				unless (self.send(attr) =~ /^http:\/\//)
					self.send( (attr.to_s + '=').to_sym, "http://" + self.send(attr) )
				end
			end
		end
	end

	#Custome getters and setters
	def rating
		rating = read_attribute(:rating)
		rating == -1? :notrated : rating
	end

	#Helpers
	def full_address
		"#{self.street_address} #{self.city}, #{self.state} #{self.zip}"
	end


end
