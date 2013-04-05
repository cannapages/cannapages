module ListingsHelper
	def listing_link_active?(target_intent, extra_classes = "")
		css_classes = ""
		if target_intent == params[:intent]
			css_classes += "active"
		end
		css_classes + " #{extra_classes}"
	end
	def best_special_for_listing(listing)
		day_name = Date.today.strftime("%A")
		message = "#{day_name.downcase}_special"
		daily_special = listing.send( message )
		weekly_special = listing.weekly_special
		daily_special or weekly_special
	end
	def setup_menu( listing )
		products = listing.live_menu.products.to_a
		hybrids = products.select{|p| p.strain.familly == "hybrid"}
		indicas = products.select{|p| p.strain.familly == "indica"}
		sativas = products.select{|p| p.strain.familly == "sativa"}
		{
			hybrids: hybrids,
			indicas: indicas,
			sativas: sativas
		}
	end
end
