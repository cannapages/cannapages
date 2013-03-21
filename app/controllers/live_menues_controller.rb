class LiveMenuesController < ApplicationController
	def edit
		@live_menu = @current_user.listings.first.live_menu
		@products = @live_menu.products
		if params[:product_id]
			@product = @live_menu.products.find(params[:product_id])
		else
			@product = Product.new
		end
		render layout: "business_backend"
	end
end
