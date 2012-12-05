class Listing
  include Mongoid::Document
  field :name, type: String
  field :phone, type: String
  field :street_address, type: String
  field :city, type: String
  field :state, type: String
  field :zip, type: String
  field :category, type: String
end
