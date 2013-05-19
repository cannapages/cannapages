class ListingsController < ApplicationController
	before_filter :require_admin, only: [:admin_index, :admin_edit, :admin_new, :admin_update, :admin_create, :admin_destroy ]
	before_filter :require_business, only: [ :edit, :new, :update, :create, :destroy ]

  def index
		@listings = Listing.limit(Listing.count)
		if params[:search] and params[:search][:query]
			reg = %r[#{params[:search][:query]}]i
			@listings = @listings.any_of(name: reg).any_of(categroy: reg)
		end
		@listings = @listings.geo_near( [@user_location.lng, @user_location.lat] ).spherical.to_a
		@listings = Kaminari.paginate_array(@listings).page(params[:page]).per(10)
		@listings.each do |l|
			l.update_distance(@user_location)
		end
		@featured_listings = Listing.where(featured: true).max_near( [@user_location.lng, @user_location.lat], 50 ).to_a
		unless @featured_listings.empty?
			@featured_listings.sort! {|x,y| x.featured_shows <=> y.featured_shows}
			@featured_listing = @featured_listings.first
			@featured_listing.featured_shows += 1
			@featured_listing.save
		end
		@featured_listing ||= nil
		@ads = side_banner_front_ads
  end
  
  def create
  end
  
  def update
  end

  def show
		params[:intent] ||= "cannawisdom"
		view = params[:intent]
		@listing = Listing.where( slug: params[:id] ).first
		render view, layout: "listing_show"
  end

  def new
		@listing = Listing.new
    render layout: "business_backend"
  end

  def edit
		@listing = @current_user.listings.first
		@form_name = "form"
		@form_name += "_#{params[:intent]}" if params[:intent]
    render layout: "business_backend"
  end
  
	def destroy
		current_user.listings.find( params[:id] ).destroy
		redirect_to roachy_tips_path
	end

  def admin_destroy
		Listing.where( slug: params[:id] ).first.destroy
		redirect_to listings_admin_index_path
  end

  def admin_index
		@listings = Listing.all.order_by( name: :asc ).to_a
		render layout: "admin_backend"
  end

  def admin_edit
		@listing = Listing.where( slug: params[:id] ).first
		render layout: "admin_backend"
  end

  def admin_new
		@listing = Listing.new
		render layout: "admin_backend"
  end
  
  def admin_update
		@listing = Listing.find_by( slug: params[:id] )
		if @listing.update_attributes( params[:listing] )
			redirect_to listings_admin_index_path
		else
			render "admin_edit"
		end
  end
  
  def admin_create
		@listing = Listing.new(params[:listing])
		if @listing.save
			redirect_to listings_admin_index_path
		else
			render "admin_new"
		end
  end


end
