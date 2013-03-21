class Ad
  include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Paperclip
  field :name, type: String
  field :href, type: String
  field :ad_type, type: String
  field :live, type: Boolean
  field :clicks, type: Integer
  field :shows, type: Integer
  field :expiration, type: Date
	has_mongoid_attached_file :ad_image, :styles => { small: "252x252#", large: "252x602#", btob: "730x92#" }

	validates_inclusion_of :ad_type, allow_nil: false, in: AD_CATEGORY_ARRAY

	belongs_to :user

	scope :for_page, ->(ad_type, num_of_ads = 1) do
		self.where( ad_type: ad_type, live: true ).limit( num_of_ads ).order_by( shows: :desc )
	end

	before_create :initialize_anylitics

	def initialize_anylitics
		self.clicks, self.shows = 0, 0
	end

	def live?
		live
	end

	def image_size
		case ad_type
			when 'Banner Small'
				:small
			when 'Banner Large'
				:large
			when 'Business to Business'
				:btob
		end
	end

end
