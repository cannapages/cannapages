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
				@title = "Where To Find Marijuana | Marijuana Dispensaries | Weed Reviews | Weed Maps"
			when "critiques"
				extra = ""
				if @critique
					extra += " | #{@critique.strain.name if @critique.strain}"
					extra += " | #{@critique.listing.name}" if @critique.listing
				end
				unless extra.empty?
					@title = "Marijuana Reviews#{ extra }"
				else
					@title = "Marijuana Reviews | #{ @critique.title }" if @critique
					@title = "Marijuana Reviews | Cannabis Dispensaries | Best Marijuana | Weed Strains" unless @critique
				end
			when "listings"
				if @listing
					@title = "#{@listing.name} | Where To Find Marijuana | Marijuana Dispensaries"
				else
					@title = "Where To Find Marijuana | Head Shops | Marijuana Dispensaries | Grow Stores"
				end
			when "volumes", "articles"
				if @article
					@title = "Marijuana News | Medical Marijuana | #{@article.title}"
				else
					@title = "Marijuana News | Medical Marijuana | Marijuana Articles | Marijuana Legal"
				end
			when "strains"
				if @strain
					@title = "#{@strain.name} | #{@strain.menu_type} | Marijuana Effects"
				else
					@title = "Indica | Sativa | Marijuana Effects | Marijuana Strains | Types of Marijuana"
				end
			when "forums", "forum_threads"
				if @forum
					@thread_extra = @thread.title if @thread
					@thread_extra ||= ""
					@title = "#{@forum.name} #{@thread_extra} | What is Marijuana | Grow Marijuana | Grow Weed"
				else
					@title = "What is Marijuana | Grow Marijuana | Grow Weed | Cannabis Growing | Marijuana Forum"
				end
			when "cadets"
				@title = "Pot and Marijuana | Marijuana Pictures | Marijuana Sale | Marijuana is Cannabis"
			else
				@title = "Where to find Marijuana | Pot and Marijuanai | Marijuanai is Cannabis"
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
				"Where to find Marijuana, Cannabis Dispensaries, Medical Marijuana Dispensaries, Head Shops, Hydroponics, Weed Reviews, Weed Maps, & Marijuana Doctors. HQ: Denver, Colorado"
			when "critiques"
				extra = ""
				if @critique
					extra += "#{@critique.listing.name}, " if @critique.listing
					extra += "#{@critique.strain.name}, " if @critique.strain
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
			when "articles", "volumes"
				extra = "#{@article.title}: " if @article
				extra ||= ""
				"#{extra}Marijuana news and marijuana articles from the world of medical marijuana and legal marijuana. Best marijuana news site."
			when "strains"
				extra = "#{@strain.name}: " if @strain
				extra ||= ""
				"#{extra}Indica and sativa marijuana strains, also marijuana effects and types of marijuana. See pictures of marijuana and where to find marijuana."
			when "forums", "forum_threads"
				extra = "#{@forum.name}: " if @forum
				extra += "#{@thread.title} " if @thread
				extra ||= ""
				"#{extra}Cannabis growing and finding out what is marijuana. Grow weed and grow marijuana questions answered."
			when "cadets"
				"Everything pot and marijuana, marijuana is cannabis! Cannabis pictures, marijuana sale, join our ranks today!"
			else
				"Information on Pot and Marijuana, Cannabis Reviews, Medical Marijuana Dispensaries, Weed Strains, and Marijuana Effects. Weed Brownies, Weed Reviews, Best Marijuana all from Cannapages.com"
		end
		set_meta_tags( :description => @description.html_safe )
	end

	private
	def scramble(str)
		s = str.split(' ').sort_by { rand }.join(' ')
		s =~ /[A-Z]/ && s =~ /[a-z]/ ? s.capitalize : s
	end
end
