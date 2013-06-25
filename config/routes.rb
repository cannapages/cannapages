C41::Application.routes.draw do
	#Admin controlled resources
	match "/highsociety" => "pages#highsociety"
  resources :pages
  resources :ads
	
	#User Authentication Routes
	get "/logout" => "sessions#destroy", as: :custom_logout
	get "/users/account/edit" => "users#edit", as: :user_account_edit
	resources :users, only: [:edit, :update, :destroy]
	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
	resources :searches

	#Business Controlled Resources
	get "/listings/admin_index" => "listings#admin_index", as: :listings_admin_index
	get "/listings/admin_new" => "listings#admin_new", as: :admin_new_listing
	get "/listings/:id/admin_edit" => "listings#admin_edit", as: :admin_edit_listing
	put "/listings/:id/admin" => "listings#admin_update", as: :admin_update_listing
	post "/listings/admin" => "listings#admin_create", as: :admin_create_listing
	delete "/listings/:id/admin" => "listings#admin_destroy", as: :admin_destroy_listing
	post "/listings/search" => "listings#index", as: :listings_search
	get "/listings/search" => "listings#index", as: :listings_search
	resources :listings do
		resources :comments, :defaults => { :commentable => 'listing' }
	end

	get "/live_menues/edit" => "live_menues#edit", as: :live_menu_edit
	get "/live_menues/:id/admin_edit" => "live_menues#admin_edit", as: :live_menu_admin_edit
	get "/products/:id/set_as_in_stock" => "products#set_as_in_stock", as: :set_product_as_in_stock
	get "/products/:id/set_as_out_of_stock" => "products#set_as_out_of_stock", as: :set_product_as_out_of_stock
	resources :products, only: [:create, :update, :destroy]
	resources :photo_uploads
	#Admin Controlled Resource
	get "/articles/admin_index" => "articles#admin_index", as: :articles_admin_index
	resources :articles
	post "/search/articles" => "articles#index", as: :articles_search
	get "/volumes/admin_index" => "volumes#admin_index", as: :volumes_admin_index
	get "/volumes/move_element/:id/:col_num/:index/:delta" => "volumes#move_element", as: :volumes_move_element
	get "/volumes/add_articles/:id/:article1_slug/:article2_slug/:article3_slug" => "volumes#add_articles", as: :volumes_add_articles
	delete "/volumes/remove_element/:id/:col_num/:index" => "volumes#remove_element", as: :volumes_remove_element
	get "/volumes/create" => "volumes#create", as: :create_volume
	resources :volumes, except: [:create]
	post "/search/critiques" => "critiques#index", as: :critiques_search
	get "/critiques/admin_index" => "critiques#admin_index", as: :critiques_admin_index
	get "/cannacritiques" => "critiques#home"
	get "/critiques/home" => "critiques#home", as: :critiques_home
	resources :critiques
	get "/strains/admin_index" => "strains#admin_index", as: :strains_admin_index

	get "/strains/:id/new_review" => "reviews#new_for_strain", as: :strain_review_new
	get "/strains/:strain_id/edit_review/:id" => "reviews#edit_for_strain", as: :strain_review_edit
	post "/strains/:id/create_review" => "reviews#create_for_strain", as: :strain_review_create
	put "/strains/:strain_id/update_review/:id" => "reviews#update_for_strain", as: :strain_review_update
	get "/strains/:strain_id/destroy_review/:id" => "reviews#destroy_for_strain", as: :strain_review_destroy
	resources :strains do
		resources :comments, :defaults => { :commentable => 'strain' }
	end

	post "/search/strains" => "strains#index", as: :strains_search
	resources :strain_tests
  resources :roachy_tips
	get "/feeds/admin_index" => "feeds#admin_index", as: :feeds_admin_index
	get "/feeds/fetch_new_articles" => "feeds#fetch_articles", as: :fetch_feed_articles
	resources :feeds

	#User Controlled Resources
	post "/forums/seach" => "forum_threads#index", as: :forums_search
	resources :forums do
		resources :forum_threads do
			resources :forum_posts
		end
	end
	resources :pipe_graves, except: [:show]

  get "cadets/home", as: :cadets_home

	root :to => "home#index"

  #Legacy routes
  match "/:state/businesses/:uri_name" => "listings#index"
  match "/:state/businesses/:uri_name/:action" => "listings#index"
  #Universal fall back to root
  match '*a', :to => 'home#index'

  get "419" => redirect("http://ezregister.com/events/6491/")
  get "/420eve" => redirect("http://ezregister.com/events/6491/")
end
