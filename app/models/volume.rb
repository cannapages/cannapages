class Volume
  include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Paperclip

	field :volume_number, type: Integer
	field :live, type: Boolean
	field :column1, type: Array
	field :column2, type: Array
	field :column3, type: Array
  has_mongoid_attached_file :volume_image, :styles => { :large => "300x300#", :small => "150x150#" }

	before_create :set_volume_number

	def add_to_column(	col_num, element )
		eval("self.column#{col_num} ||= []")
		eval("self.column#{col_num} += [{slug: '#{element.slug}', element_class: '#{element.class}'}]")
	end

	def get_3_col_array
		self.column1 ||= []
		self.column2 ||= []
		self.column3 ||= []
		col1 = []
		col2 = []
		col3 = []
		self.column1.each do |element|
			col1 << eval("#{element['element_class']}.find_by( slug: \"#{element['slug']}\" )")
		end
		self.column2.each do |element|
			col2 << eval("#{element['element_class']}.find_by( slug: \"#{element['slug']}\" )")
		end
		self.column3.each do |element|
			col3 << eval("#{element['element_class']}.find_by( slug: \"#{element['slug']}\" )")
		end
		[col1,col2,col3]
	end

	def set_volume_number
		last_volume = Volume.order_by( created_at: :desc ).first
		last_volume_number = last_volume.volume_number if last_volume
		last_volume_number ||= 0
		self.volume_number = last_volume_number + 1
	end
end
