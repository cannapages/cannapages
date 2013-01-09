module DistanceHelper
	
	# PI = 3.1415926535
	RAD_PER_DEG = 0.017453293  #  PI/180

	# the great circle distance d will be in whatever units R is in
	Rmiles = 3956           # radius of the great circle in miles
	Rkm = 6371              # radius in kilometers...some algorithms use 6367
	Rfeet = Rmiles * 5282   # radius in feet
	Rmeters = Rkm * 1000    # radius in meters

	def self.distance_between_objects( obj1, obj2 )
		lat1 = obj1.lat
		lng1 = obj1.lng
		lat2 = obj2.lat
		lng2 = obj2.lng
		distance_between( lat1, lng1, lat2, lng2 )
	end

	def self.distance_between( lat1, lon1, lat2, lon2, type )
		return "Unkown" if ( lat1.nil? or lon1.nil? or lat2.nil? or lon2.nil? )
		dlon = lon2 - lon1
		dlat = lat2 - lat1

		dlon_rad = dlon * RAD_PER_DEG 
		dlat_rad = dlat * RAD_PER_DEG

		lat1_rad = lat1 * RAD_PER_DEG
		lon1_rad = lon1 * RAD_PER_DEG

		lat2_rad = lat2 * RAD_PER_DEG
		lon2_rad = lon2 * RAD_PER_DEG

		# puts "dlon: #{dlon}, dlon_rad: #{dlon_rad}, dlat: #{dlat}, dlat_rad: #{dlat_rad}"

		a = (Math.sin(dlat_rad/2))**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * (Math.sin(dlon_rad/2))**2
		c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a))

		dMi = Rmiles * c          # delta between the two points in miles
		dKm = Rkm * c             # delta in kilometers
		dFeet = Rfeet * c         # delta in feet
		dMeters = Rmeters * c     # delta in meters

		# Return distance in units based on type paramiter
		case type
			when :mi
				dMi
			when :km
				dKm
			when :ft
				dFeet
			when :m
				dMeters
			else
				dMi
		end
	
	end

end
