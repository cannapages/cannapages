C41::Application.routes.draw do

	root :to => "home#index"
	
	#User Authentication Routes
	get "/logout" => "sessions#destroy", as: :custom_logout
	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
	resources :searches

	#Business Controlled Resources
	get "/listings/admin_index" => "listings#admin_index", as: :listings_admin_index
	get "/listings/admin_new" => "listings#admin_new", as: :admin_new_listing
	get "/listings/:id/admin_edit" => "listings#admin_edit", as: :admin_edit_listing
	put "/listings/:id/admin" => "listings#admin_update", as: :admin_update_listing
	post "/listings/admin" => "listings#admin_create", as: :admin_create_listing
	delete "/listings/:id/admin" => "listings#admin_destroy", as: :admin_destroy_listing
	resources :listings

	get "/live_menues/edit" => "live_menues#edit", as: :live_menu_edit
	get "/products/:id/set_as_in_stock" => "products#set_as_in_stock", as: :set_product_as_in_stock
	get "/products/:id/set_as_out_of_stock" => "products#set_as_out_of_stock", as: :set_product_as_out_of_stock
	resources :products, only: [:create, :update, :destroy]
	resources :photo_uploads
	#Admin Controlled Resource
	get "/articles/admin_index" => "articles#admin_index", as: :articles_admin_index
	resources :articles
	get "/volumes/admin_index" => "volumes#admin_index", as: :volumes_admin_index
	get "/volumes/create" => "volumes#create", as: :create_volume
	resources :volumes, except: [:create]
	get "/critiques/admin_index" => "critiques#admin_index", as: :critiques_admin_index
	resources :critiques
	get "/strains/admin_index" => "strains#admin_index", as: :strains_admin_index
	resources :strains
	resources :strain_tests
  resources :roachy_tips
	get "/rss_feeds/admin_index" => "rss_feeds#admin_index", as: :rss_feeds_admin_index
	resources :rss_feeds

	#User Controlled Resources
	resources :forums
	resources :forum_threads
	resources :forum_posts

end
