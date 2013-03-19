module ApplicationHelper
	def directions_to( address )
		link_to "Get Direction", "http://maps.google.com/maps?q=#{address}", target: "_blank"
	end
end
