class Search
  include Mongoid::Document
	include Mongoid::Timestamps
  field :query, type: String
  field :user_location, type: String
	field :type, type: String

	validates_inclusion_of :type, allow_nil: false, in: SEARCH_TYPE_ARRAY
end
