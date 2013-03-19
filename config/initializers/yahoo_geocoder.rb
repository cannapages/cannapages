class YahooHelper

	def self.new
		api_key = "dj0yJmk9ZnhpR3hkNENVaG5LJmQ9WVdrOWRXODVWazFXTnpnbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD0yYQ--"
		Placefinder::Base.new(:api_key => api_key)
	end

	def self.get_location_data( address )
		placefinder = self.new
		begin
			result = placefinder.get(:q => address, :flags => 'J')
			result["ResultSet"]["Results"].first
		rescue
			result = {}
		end
	end

end
