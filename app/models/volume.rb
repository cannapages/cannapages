class Volume
  include Mongoid::Document
	include Mongoid::Timestamps

	embeds_many :articles
end
