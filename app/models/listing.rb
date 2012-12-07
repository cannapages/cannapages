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
	
	#Validations
	validates_inclusion_of :state, allow_nil: false, in: LEGAL_STATE_ARRAY
	validates_inclusion_of :category, allow_nil: false, in: LISTING_CATEGORY_ARRAY

	#Relations
	has_one :listing_review
	embeds_many :comments

	#Callbacks
	before_save :initialize_anylitics, :initialize_dependencies, :format_phone, :update_lat_lng?, :ensure_http

	def initialize_dependencies
		create_listing_review
	end

	def initialize_anylitics
		self.shows, self.clicks, self.featured_shows, self.featured_clicks = 0,0,0,0
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
			unless (self.send(attr) =~ /^http:\/\//)
				self.send( (attr.to_s + '=').to_sym, "http://" + self.send(attr) )
			end
		end
	end

	#Helpers
	def full_address
		"#{self.street_address} #{self.city}, #{self.state} #{self.zip}"
	end


end
