class UserLocation

	attr_accessor :lat, :lng, :city, :state, :zip_code, :street_address

  def initialize(lat, lng, city, state, zip_code, street_address)
    @lat, @lng, @city, @state, @zip_code, @street_address = 
		lat, lng, city, state, zip_code, street_address
  end

	def self.new_from_ip( ip )
		result = YahooHelper::get_location_data( ip )
		self.new_from_yahoo_result( result )
	end

	def self.new_from_location( address )
		result = YahooHelper::get_location_data( address )
		self.new_from_yahoo_result( result )
	end

	def self.new_from_yahoo_result( result )
		self.new( result["latitude"], result["longitude"], result["city"], result["state"], result["uzip"], result["street"] )
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