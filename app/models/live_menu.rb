class LiveMenu
  include Mongoid::Document
	field :listing_id, type: String
	belongs_to :listing
	has_many :products
end
