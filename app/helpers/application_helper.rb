module ApplicationHelper
	def directions_to( address )
		link_to "Get Direction", "http://maps.google.com/maps?q=#{address}", target: "_blank"
	end
	def backend_link
		roles = @current_user.roles
		if roles.include?("Admin")
			target_path = new_critique_path
		elsif roles.include?("Business")
			target_path = new_listing_path
		else
			target_path = "#"
		end
		link_to "Backend", target_path
	end
end
