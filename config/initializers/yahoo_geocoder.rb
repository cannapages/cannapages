class YahooHelper

	def self.get_location_data( query )
		result = Geocoder.search( query ).first.data
	end

end
