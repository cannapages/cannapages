module HomeHelper
	def best_special_for_home_page(listing)
		day_name = Date.today.strftime("%A")
		message = "#{day_name.downcase}_special"
		daily_special = listing.send( message )
		weekly_special = listing.weekly_special
		if daily_special or weekly_special
			("<span>#{day_name} Special:</span> #{daily_special or weekly_special}").html_safe
		end
	end

end
