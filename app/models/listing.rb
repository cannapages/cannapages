class Listing
	#Modules
  include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Paperclip
	include Mongoid::MultiParameterAttributes
	has_mongoid_attached_file :logo, :styles => { thumb: "75x75#", medium: "150x150#", large: "250x250#" }

	#Fields
	#Info
  field :name, type: String
	field :slug, type: String
	field :about, type: String
  field :phone, type: String
  field :street_address, type: String
  field :city, type: String
  field :state, type: String
  field :zip, type: String

  field :lat, type: Float
  field :lng, type: Float
	field :loc, type: Array

	field :website, type: String
	field :twitter, type: String
	field :facebook, type: String
	#Service types
  field :category, type: Array
	field :match_coupons, type: Boolean
	field :glass_sale, type: Boolean
	field :whole_sale, type: Boolean
	#Account
	field :featured, type: Boolean
	field :featured_expiration, type: Date
	field :creamocrop, type: Boolean
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
	#Business Hours
	field :monday_start, type: Time
	field :monday_end, type: Time
	field :tuesday_start, type: Time
	field :tuesday_end, type: Time
	field :wednesday_start, type: Time
	field :wednesday_end, type: Time
	field :thursday_start, type: Time
	field :thursday_end, type: Time
	field :friday_start, type: Time
	field :friday_end, type: Time
	field :saturday_start, type: Time
	field :saturday_end, type: Time
	field :sunday_start, type: Time
	field :sunday_end, type: Time
	#Specials
	field :first_timers, type: String
	field :monday_special, type: String
	field :tuesday_special, type: String
	field :wednesday_special, type: String
	field :thurday_special, type: String
	field :thursday_special, type: String
	field :friday_special, type: String
	field :saturday_special, type: String
	field :sunday_special, type: String
	field :weekly_special, type: String

	#Relations
	belongs_to :user	
	has_many :critiques

	#Virtual Attributes
	attr_accessor :distance

	#Indexes
	index(
  	{ loc: Mongo::GEO2D },
		{ background: true, sparse: true }
	)

	#Scopes
	scope :near, ->(location,distance) do
		where(:loc => {"$near" => location , '$maxDistance' => distance.fdiv(69.172)})
	end
	scope :near_with_max, ->(location, distance) do
		geo_near( location ).spherical
	end
	scope :alt_near, ->(location) do
		geo_near( location ).spherical
	end
	scope :featured, ->(limit) do
		where( featured: true ).order_by( featured_shows: :desc ).limit(limit)
	end

	#Validations
	validates_inclusion_of :state, allow_nil: false, in: LEGAL_STATE_ARRAY
	validates_inclusion_of :category, allow_nil: false, in: LISTING_CATEGORY_ARRAY

	#Relations
	has_one :listing_review, autobuild: true, autosave: true
	has_one :live_menu, autobuild: true
	has_many :strain_tests
	embeds_many :comments

	#Callbacks
	before_save :format_phone, :update_lat_lng?, :ensure_http, :update_slug
	before_create :initialize_dependencies, :initialize_anylitics

	def to_param
		slug
	end

	def update_slug
		self.slug = name.downcase.gsub(" ","-")
	end

	def update_distance( from )
		self.distance = DistanceHelper.distance_between_objects( from, self )
	end

	def initialize_dependencies
		create_listing_review unless listing_review
		self.rating = listing_review.average_rating
		
		create_live_menu unless live_menu
	end

	def initialize_anylitics
		self.shows, self.clicks, self.featured_shows, self.featured_clicks, self.num_of_reviews, self.creamocrop = 0,0,0,0,0,false
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
		location_object = YahooHelper.get_location_data( self.full_address )
		lng = location_object["longitude"]
		lat = location_object["latitude"]
		self.loc = [lat.to_f,lng.to_f]
		self.lng = lng
		self.lat = lat
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
		rating || 0
	end

	#Helpers
	def full_address
		"#{self.street_address} #{self.city}, #{self.state} #{self.zip}"
	end

	def formated_phone
		"#{phone[0..2]}-#{phone[3..5]}-#{phone[5..9]}"
	end

end
