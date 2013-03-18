class Strain
  include Mongoid::Document
	include Mongoid::Timestamps
  field :name, type: String
  field :dominance, type: String
	field :origins, type: String
	field :flowering_time, type: String
	field :bio, type: String
	field :genetics, type: String
	field :slug, type: String

	#Scientific
  field :thc, type: Float
  field :cbd, type: Float
  field :cbn, type: Float
  field :total_cannabinoids, type: Float

	has_many :strain_tests
	has_many :critiques

	# validates_inclusion_of :dominance, allow_nil: false, in: STRAIN_DOMINANCE_ARRAY
	# validate :sum_of_percentages_makes_sense
	# before_validation :ensure_dominance
	# validates :thc, :inclusion => {:in => 0.0..100.0}
	# validates :cbd, :inclusion => {:in => 0.0..100.0}
	# validates :cbn, :inclusion => {:in => 0.0..100.0}

	before_save :update_slug

	def update_slug
		self.slug = name.gsub(" ","-").downcase.gsub("#", '')
	end

	def to_param
		slug
	end

	def ensure_dominance
		self.dominance ||= "Hybrid"
	end

	def sum_of_percentages_makes_sense
		errors.add(:thc, "The sum of percentages must be less than 100") unless thc + cbd + cbn <= 100
	end

	def bio_exerpt
		chars = bio.length
		(chars > 100) ? (bio[0..97] + "...") : bio
	end

	scope :one_randome, Proc.new { limit(-1).skip( Random.rand(Strain.count) ) }
end
