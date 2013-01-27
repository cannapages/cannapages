class Search
  include Mongoid::Document
	include Mongoid::Timestamps
  field :query, type: String
  field :user_location, type: String
	field :type, type: String
end
