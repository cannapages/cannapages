class Volume
  include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Paperclip

	field :volume_number, type: Integer
	field :live, type: Boolean
  has_mongoid_attached_file :volume_image, :styles => { :large => "300x300#", :small => "150x150#" }

	has_many :articles

	before_create :set_volume_number

	def set_volume_number
		last_volume = Volume.order_by( created_at: :desc ).first
		last_volume_number = last_volume.volume_number if last_volume
		last_volume_number ||= 0
		self.volume_number = last_volume_number + 1
	end
end
