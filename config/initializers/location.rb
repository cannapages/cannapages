class UserLocation

	attr_accessor :lat, :lng, :city, :state, :zip_code, :street_address, :ip

  def initialize(lat, lng, city, state, zip_code, street_address)
    @lat, @lng, @city, @state, @zip_code, @street_address = 
		lat, lng, city, state, zip_code, street_address
  end

	def self.new_from_ip( ip )
		geo = Geokit::Geocoders::IpGeocoder.geocode( ip )
		self.new_with_geo( geo )
	end

	def self.new_from_location( address )
		geo = Geokit::Geocoders::GoogleGeocoder.geocode address
		self.new_with_geo( geo )
	end

	def self.new_with_geo( geo )
		if geo.zip.nil?
			self.new( geo.lat, geo.lng, geo.city, geo.state, nil, geo.street_address )
		else
			self.new( geo.lat, geo.lng, geo.city, geo.state, geo.zip[0..4], geo.street_address )
		end
	end
	
	def max_info_string
		out = ""
		out += "#{self.street_address} " if self.street_address
		out += "#{self.city} " if self.city
		out += "#{self.state} " if self.state
		out += "#{self.zip_code} " if self.zip_code
		out = out[0..(out.size - 2)] unless out.empty?
		out.empty? ? nil : out
	end

end
