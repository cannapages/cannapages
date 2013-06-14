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
			target_path = user_account_edit_path
		end
		link_to "Backend", target_path
	end
	def cadets_backend_link
		roles = @current_user.roles
		if roles.include?("Admin")
			target_path = new_critique_path
		elsif roles.include?("Business")
			target_path = new_listing_path
		else
			target_path = user_account_edit_path
		end
		link_to( image_tag("cadetspage-logo.png"), target_path, class: :cadets_sign_up )
	end

	def derived_search_form
		form_partial_name = case params[:controller]
			when "volumes"
				"articles"
			when "devise/registrations"
				"listings"
			when "cadets"
				"listings"
			when "pages"
				"listings"
			when "forum_threads"
				"forums"
			when "reviews"
				"listings"
			else
				params[:controller]
		end
		render "searches/#{form_partial_name}"
	end

	def seo_title
		@title = case params[:controller]
			when :home
				"CannaPages: best marijuana | canibus dispensaries | weed reviews | weedmaps"
			else
				"CannaPages: best marijuana | canibus dispensaries | weed reviews | weedmaps"
		end
		@title
	end

	def seo_h1
		scramble( (@title + " " + @description).gsub("|","") )
	end

	def generate_meta
		seo_description
	end

	def seo_key_words
		key_words = ["test"]
		set_meta_tags( :keywords => key_words )
	end

	def seo_description
		@description = case params[:controller]
			when :home
				"Cannabis Dispensaries, Medical Marijuana Dispensaries, Head Shops, Hydroponics, Weed Reviews, Weed Maps, & Marijuana Doctors. Find where to buy weed! HQ: Denver, Colorado"
			else
				"Cannabis Dispensaries, Medical Marijuana Dispensaries, Head Shops, Hydroponics, Weed Reviews, Weed Maps, & Marijuana Doctors. Find where to buy weed! HQ: Denver, Colorado"
		end
		set_meta_tags( :description => @description.html_safe )
	end

	private
	def scramble(str)
		s = str.split(' ').sort_by { rand }.join(' ')
		s =~ /[A-Z]/ && s =~ /[a-z]/ ? s.capitalize : s
	end
end
