class UserLocation

	attr_accessor :lat, :lng, :city, :state, :zip_code, :street_address

  def initialize(lat = nil, lng = nil, city = nil, state = nil, zip_code = nil, street_address = nil)
    @lat, @lng, @city, @state, @zip_code, @street_address = 
		lat, lng, city, state, zip_code, street_address
  end

	def self.new_from_ip( ip )
		ip = "204.144.141.26" if ip == "127.0.0.1"
		result = YahooHelper::get_location_data( ip )
		self.new_from_yahoo_result( result )
	end

	def self.new_from_location( address )
		result = YahooHelper::get_location_data( address )
		self.new_from_yahoo_result( result )
	end

	def self.new_from_yahoo_result( result )
		self.new(result["latitude"].to_f, result["longitude"].to_f, result["city"], result["state"], result["uzip"], result["line1"])
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
