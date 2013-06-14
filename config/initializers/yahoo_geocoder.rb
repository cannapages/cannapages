class YahooHelper

	def self.get_location_data( query )
		result = Geocoder.search( query ).first
		result.data if result.respond_to? :data
	end

end
