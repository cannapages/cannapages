class Product
  include Mongoid::Document
	include Mongoid::Timestamps
  field :strain_name, type: String
  field :strain_id, type: String
  field :quantity_in_stock, type: Float
	field :binary_in_stock, type: Boolean
  field :price_1_8, type: Float
  field :price_1_4, type: Float
  field :price_1_2, type: Float
  field :price_whole, type: Float
	field :binary_mode, type: Boolean #If true product will be in mode 1
	# Mode description
	# Mode1: iether in or out of stock
	# Mode2: Actually quanity in ounces is tracked

	before_save :insure_positive_stock

	def insure_positive_stock
		self.quantity_in_stock = 0 if quantity_in_stock < 0
	end

	def in_stock?
		if binary_mode
			binary_in_stock
		else
			(!quantity_in_stock.nil?) and (quantity_in_stock > 0)
		end
	end	


end
