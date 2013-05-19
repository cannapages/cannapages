class Page
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :slug, type: String
  field :content, type: String
  field :views, type: Integer

	before_create :initilize_anylitics
	before_save :update_slug

	def initilize_anylitics
		self.views = 0
	end

	def update_slug
		self.slug = name.parameterize
	end

	def to_param
		slug
	end
end
