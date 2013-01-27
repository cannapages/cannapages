class Volume
  include Mongoid::Document
	include Mongoid::Timestamps

	has_many :articles
end
