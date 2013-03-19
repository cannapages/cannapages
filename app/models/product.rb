class Product
  include Mongoid::Document
	include Mongoid::Timestamps
  field :strain_name, type: String
  field :strain_id, type: String
	field :in_stock, type: Boolean
  field :price_1_8, type: Float
  field :price_1_4, type: Float
  field :price_1_2, type: Float
  field :price_whole, type: Float
	field :binary_mode, type: Boolean #If true product will be in mode 1

	def in_stock?
		in_stock
	end	


end
