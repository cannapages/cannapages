module HomeHelper
	def best_special_for_home_page(listing)
		day_name = Date.today.strftime("%A")
		("<span>#{day_name} Special:</span> #{listing.best_special}").html_safe
	end
	def best_special_for_home_page_slider(listing)
		day_name = Date.today.strftime("%A")
		("<p class='red'>#{day_name} Special:</p> <p>#{listing.best_special}</p>").html_safe
	end

end
