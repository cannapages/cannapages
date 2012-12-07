C41::Application.routes.draw do
  get "home/index"
  get "home/critiques"

	root :to => "home#index"
	devise_for :users

	resources :searches
end
