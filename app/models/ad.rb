class Ad
  include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Paperclip
	include Mongoid::MultiParameterAttributes
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

	scope :live, where( live: true ).where( :expiration.gte => Date.today )
	scope :one_small, live.order_by( shows: :desc ).where( ad_type: "Banner Small" ).limit(1)
	scope :one_large, live.order_by( shows: :desc ).where( ad_type: "Banner Large" ).limit(1)
	scope :one_btb, live.order_by( shows: :desc ).where( ad_type: "Business to Business" ).limit(1)

end
