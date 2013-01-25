C41::Application.routes.draw do
	root :to => "home#index"
	devise_for :users
	resources :searches

	get "/listings/admin_index" => "listings#admin_index", as: :listings_admin_index
	get "/listings/:id/admin_edit" => "listings#admin_edit", as: :admin_edit_listing
	put "/listings/:id/admin" => "listings#admin_update", as: :admin_update_listing
	get "/listings/admin_new" => "listings#admin_new", as: :admin_new_listing
	post "/listings/admin" => "listings#admin_create", as: :admin_create_listing
	get "/searches/admin_index" => "controller#action", as: "searchs_admin_index"
	resources :listings

end
