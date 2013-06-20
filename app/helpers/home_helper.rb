module HomeHelper
	def best_special_for_home_page(listing)
		day_name = Date.today.strftime("%A")
		("<span>Marijuana Sale #{day_name}:</span> #{listing.best_special}").html_safe
	end
	def best_special_for_home_page_slider(listing)
		day_name = Date.today.strftime("%A")
		("<p class='red'>Marijuana Sale #{day_name}</p> <p>#{listing.best_special}</p>").html_safe
	end

end
