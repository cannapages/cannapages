module ApplicationHelper
	def directions_to( address )
		link_to "Get Directions", "http://maps.google.com/maps?q=#{address}", target: "_blank"
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

	def derived_search_form
		form_partial_name = case params[:controller]
			when "volumes"
				"articles"
			else
				params[:controller]
		end
		render "searches/#{form_partial_name}"
	end
end
