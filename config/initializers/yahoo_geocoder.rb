class YahooHelper

	def self.new
		api_key = ""
		Placefinder::Base.new(:api_key => 'dj0yJmk9ZnhpR3hkNENVaG5LJmQ9WVdrOWRXODVWazFXTnpnbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD0yYQ--')
	end

	def self.get_location_data( address )
		placefinder = self.new
		result = placefinder.get(:q => address, :flags => 'J')
		result["ResultSet"]["Results"].first
	end

end
