C41::Application.routes.draw do
  get "forums/index"

  get "forums/show"

  get "forums/edit"

  get "forums/new"

  get "rss_feeds/index"

  get "rss_feeds/admin_index"

  get "rss_feeds/new"

  get "rss_feeds/edit"

  get "strains/index"

  get "strains/show"

  get "strains/new"

  get "strains/edit"

  get "critiques/index"

  get "critiques/show"

  get "critiques/new"

  get "critiques/edit"

  get "articles/index"

  get "articles/show"

  get "articles/new"

  get "articles/edit"

  get "listings/index"

  get "listings/show"

  get "listings/new"

  get "listings/edit"

  get "listings/admin_index"

  get "listings/admin_edit"

  get "listings/admin_new"

  get "home/index"
  get "home/critiques"

	root :to => "home#index"
	devise_for :users

	resources :searches
end
