class Coupon
  include Mongoid::Document
	include Mongoid::Timestamps
  field :deal, type: String
  field :expires, type: Boolean
  field :expiration_date, type: Date
end
