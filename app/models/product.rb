class Product
  include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Paperclip
	field :in_stock, type: Boolean
  field :price_1_16, type: Float
  field :price_1_8, type: Float
  field :price_1_4, type: Float
  field :price_1_2, type: Float
  field :price_ounce, type: Float
	has_mongoid_attached_file :product_image, :styles => { thumb: "75x75#", regular: "150x150#" }

	belongs_to :live_menu
	belongs_to :strain

	def in_stock?
		in_stock
	end	

	def best_image_tag
		if self.product_image?
			self.product_image(:regular)
		elsif self.strain and self.strain.strain_tests.count > 1 and self.strain.strain_tests.first.image.exists?
			self.strain.strain_tests.first.image(:medium)
		else
			"/assets/generic_flower_320.jpg"
		end
	end

end
