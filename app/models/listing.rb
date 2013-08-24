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
	field :has_slug, type: Boolean
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
	#Ratings
	field :creamocrop, type: Boolean
	field :rating
	#Anylitics
	field :shows, type: Integer
	field :clicks, type: Integer
	field :featured_shows, type: Integer
	field :featured_clicks, type: Integer
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
	has_many :photo_uploads
	has_many :comments, as: :commentable
	has_one :live_menu, autobuild: true
	has_many :strain_tests

	#Virtual Attributes
	attr_accessor :distance

	#Indexes
	index(
  	{ loc: Mongo::GEO2D },
		{ background: true, sparse: true }
	)

	#Scopes
	scope :max_near, ->(location,distance) do
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


	#Callbacks
	before_save :format_phone, :update_lat_lng?, :ensure_http, :update_slug?, :nulify_empty_values
	before_create :initialize_dependencies, :initialize_anylitics

	def update_rating
		total_rating = comments.each.inject(0) {|r,c| r + c.rating}
		self.rating = (total_rating / comments.size).to_i
		save
	end

	def has_media?
		not photo_uploads.empty?
	end

	def has_menu?
		live_menu.products.count > 0
	end

	def specials
		{
			weekly: weekly_special,
			monday: monday_special,
			tuesday: tuesday_special,
			wednesday: wednesday_special,
			thursday: thursday_special,
			friday: friday_special,
			saturday: saturday_special,
			sunday: sunday_special
		}
	end

	def best_special
		day_name = Date.today.strftime("%A")
		message = "#{day_name.downcase}_special"
		daily = send(message)
		if daily
			return daily
		elsif weekly_special
			return weekly_special
		else
			return first_found_special
		end
	end

	def first_found_special
		specials_array = specials.select{|k,v| not v.nil? }
		specials_array.first.last unless specials_array.empty?
	end
	
	def has_specials?
		specials.each do |key,value|
			return true if value and not value.empty?
		end
		false
	end

	def to_param
		slug
	end

	def nulify_empty_values
			self.weekly_special = nil if self.weekly_special.empty?
			self.monday_special = nil if self.monday_special.empty?
			self.tuesday_special = nil if self.tuesday_special.empty?
			self.wednesday_special = nil if self.wednesday_special.empty?
			self.thursday_special = nil if self.thursday_special.empty?
			self.friday_special = nil if self.friday_special.empty?
			self.saturday_special = nil if self.saturday_special.empty?
			self.sunday_special = nil if self.sunday_special.empty?
	end

	def update_slug?
		update_slug unless has_slug
	end

	def update_slug
		self.slug = name.downcase.gsub(" ","-")
		same_slugs = Listing.where( slug: slug ).count
		if same_slugs > 0
			self.slug += "-#{(same_slugs + 1).to_s}"
		end
		self.has_slug = true
	end

	def update_distance( from )
		self.distance = DistanceHelper.distance_between_objects( from, self )
	end

	def initialize_dependencies
		create_live_menu unless live_menu
	end

	def initialize_anylitics
		self.shows, self.clicks, self.featured_shows, self.featured_clicks, self.creamocrop = 0,0,0,0,false
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
		location = UserLocation.new_from_location( self.full_address )
		lng = location.lng
		lat = location.lat
		self.loc = [lng.to_f,lat.to_f]
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

	#Helpers
	def full_address
		"#{self.street_address} #{self.city}, #{self.state} #{self.zip}"
	end

	def formated_phone
		"#{phone[0..2]}-#{phone[3..5]}-#{phone[6..9]}"
	end

	def cannawisdom
		if about.nil? or about.empty?
			"#{name} is a #{category.downcase} located in #{city}, #{state}"
		else
			about
		end
	end

end
