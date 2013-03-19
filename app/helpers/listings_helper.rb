module ListingsHelper
	def listing_link_active?(target_intent, extra_classes = "")
		css_classes = ""
		if target_intent == params[:intent]
			css_classes += "active"
		end
		css_classes + " #{extra_classes}"
	end
end
