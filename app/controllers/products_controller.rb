class ProductsController < ApplicationController

	def create
		set_up_product
		if @product.valid?
			live_menu = current_user.listings.first.live_menu
			@product.in_stock = true
			@product.save
			live_menu.products << @product
			live_menu.save
			redirect_to live_menu_edit_path, notice: "Created Product"
		else
			redirect_to live_menu_edit_path, notice: "Could not create product check your entry data"
		end
	end

	def update
		@product = Product.find( params[:id] )
		if @product.update_attributes( params[:product] )
			redirect_to live_menu_edit_path, notice: "Updated Product"
		else
			redirect_to live_menu_edit_path( product_id: @product.id ), notice: "Could not update the product check you entry data"
		end
	end

	def set_as_in_stock
		@product = @current_user.listings.first.live_menu.products.find( params[:id] )
		@product.in_stock = true
		@product.save
		redirect_to live_menu_edit_path
	end

	def set_as_out_of_stock
		@product = @current_user.listings.first.live_menu.products.find( params[:id] )
		@product.in_stock = false
		@product.save
		redirect_to live_menu_edit_path
	end

	def destroy
		Product.find( params[:id] ).destroy
		redirect_to live_menu_edit_path
	end

	private
	def set_up_product
		# params[:product][:in_stock] = ((params[:product][:in_stock] == 'yes') ? true : false)
		@product = Product.new( params[:product] )
	end

end
