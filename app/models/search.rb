class Search
  include Mongoid::Document
  field :query, type: String
  field :user_location, type: String
end
