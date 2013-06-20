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
		case params[:controller]
			when "home"
				@title = "CANNAPAGES: Where To Find Marijuana | Marijuana Dispensaries | Weed Reviews | Weed Maps"
			when "critiques"
				extra = ""
				if @critique
					extra += " | #{@critique.strain.name if @critique.strain}"
					extra += " | #{@critique.listing.name}" if @critique.listing
				end
				unless extra.empty?
					@title = "CANNACRITIQUES: Marijuana Reviews#{ extra }"
				else
					@title = "CANNACRITIQUES: Marijuana Reviews | #{ @critique.title }" if @critique
					@title = "CANNACRITIQUES: Marijuana Reviews | Cannabis Dispensaries | Best Marijuana | Weed Strains" unless @critique
				end
			when "listings"
				if @listing
					@title = "CANNAPAGES: #{@listing.name} | Where To Find Marijuana | Marijuana Dispensaries"
				else
					@title = "CANNAPAGES: Where To Find Marijuana | Head Shops | Marijuana Dispensaries | Grow Stores"
				end
			else
				@title = "CANNAPAGES: Medical Marijuana | Cannabis Dispensaries | Weed Reviews | Weedmaps"
		end
		@title
	end

	def seo_h1
		@title.gsub!("Where To Find Marijuana", "")
		@title.gsub!("Where To Find Weed", "")
		"Where To Find Marijuana " + scramble( (@title + " " + @description).gsub("|","") )
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
			when "home"
				"Cannabis Dispensaries, Medical Marijuana Dispensaries, Head Shops, Hydroponics, Weed Reviews, Weed Maps, & Marijuana Doctors. Find where to buy weed! HQ: Denver, Colorado"
			when "critiques"
				extra = ""
				if @critique
					extra += "#{@critique.listing.name}, " if @critique.listing
					extra += "#{@critique.strain.name}, " if @critique.listing
					extra += "#{@critique.title}, " unless @critique.listing or @critique.strain
				end
				"#{extra}Cannabis Reviews, Medical Marijuana Dispensaries, Weed Strains, and Marijuana Effects. Weed Brownies, Weed Reviews, Best Marijuana all from Cannapages.com"
			when "listings"
				extra = ""
				if @listing
					extra += "#{@listing.cannawisdom} | Where to find Marijuana"
				else
					"#{extra}Cannabis Reviews, Medical Marijuana Dispensaries, Weed Strains, and Marijuana Effects. Weed Brownies, Weed Reviews, Best Marijuana all from Cannapages.com"
				end
			else
				"Cannabis Reviews, Medical Marijuana Dispensaries, Weed Strains, and Marijuana Effects. Weed Brownies, Weed Reviews, Best Marijuana all from Cannapages.com"
		end
		set_meta_tags( :description => @description.html_safe )
	end

	private
	def scramble(str)
		s = str.split(' ').sort_by { rand }.join(' ')
		s =~ /[A-Z]/ && s =~ /[a-z]/ ? s.capitalize : s
	end
end
