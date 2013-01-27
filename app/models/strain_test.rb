class StrainTest
  include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Paperclip
  field :strain_name, type: String
  field :business_name, type: String
  field :dominance, type: String
  field :thc, type: Float
  field :cbd, type: Float
  field :cbn, type: Float
  field :total_cannabinoids, type: Float

	has_mongoid_attached_file :image, :styles => { thumb: "70x70#", medium: "320x320#" }

	validates_inclusion_of :dominance, allow_nil: false, in: STRAIN_DOMINANCE_ARRAY
	validate :sum_of_percentages_makes_sense
	validates :thc, :inclusion => {:in => 0.0..100.0}
	validates :cbd, :inclusion => {:in => 0.0..100.0}
	validates :cbn, :inclusion => {:in => 0.0..100.0}

	belongs_to :listing
	belongs_to :strain

	before_validation :ensure_dominance
	before_save :derive_names

	def derive_names
		unless listing.nil? or business_name
			self.business_name = listing.name
		end
		unless strain.nil? or strain_name
			self.strain_name = strain.name
		end
	end

	def ensure_dominance
		self.dominance ||= "Hybrid"
	end

	def sum_of_percentages_makes_sense
		errors.add(:thc, "The sum of percentages must be less than 100") unless thc + cbd + cbn <= 100
	end

end
