C41::Application.routes.draw do
	root :to => "home#index"
	devise_for :users
	resources :searches

	get "/listings/admin_index" => "listings#admin_index", as: :listings_admin_index
	get "/listings/:id/admin_edit" => "listings#admin_edit", as: :admin_edit_listing
	put "/listings/:id/admin" => "listings#admin_update", as: :admin_update_listing
	get "/listings/admin_new" => "listings#admin_new", as: :admin_new_listing
	post "/listings/admin" => "listings#admin_create", as: :admin_create_listing
	resources :listings
	resources :articles
	resources :critiques
	resources :strains
	
	get "rss_feeds/admin_index" => "rss_feeds#admin_index", as: :rss_feeds_admin_index
	resources :rss_feeds
	resources :forum
	

end
