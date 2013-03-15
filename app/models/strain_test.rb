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
	field :slug, type: String

	has_mongoid_attached_file :image, :styles => { thumb: "70x70#", medium: "320x320#" }

	validates_inclusion_of :dominance, allow_nil: false, in: STRAIN_DOMINANCE_ARRAY
	validate :sum_of_percentages_makes_sense
	validates :thc, :inclusion => {:in => 0.0..100.0}
	validates :cbd, :inclusion => {:in => 0.0..100.0}
	validates :cbn, :inclusion => {:in => 0.0..100.0}

	belongs_to :listing
	belongs_to :strain

	before_validation :ensure_dominance
	before_create :generate_slug
	before_save :derive_names, :update_pie_chart

	def chart_url
		"/charts/strain-tests/#{slug}.png"
	end

	def generate_slug
		self.slug = (strain_name.downcase.gsub(" ","-") + "-" + 
		business_name.downcase.gsub(" ","-") + "-" + Date.today.strftime("%D").gsub("/","-")).gsub("'",'-').gsub('"','-')
	end

	def update_pie_chart
		R.eval "png(file='#{Rails.root}/public/charts/strain-tests/#{slug}.png')"
		R.eval "slices <- c(#{total_cannabinoids}, #{100 - total_cannabinoids})"
		R.eval 'lbls <- c("Cannabinoids","Other")'
		R.eval 'pie(slices, labels = lbls, main="Cannabinoids vs Non Cannabinoids")'
		R.eval "dev.off()"
	end

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
