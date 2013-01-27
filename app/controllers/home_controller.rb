class HomeController < ApplicationController
	# before_filter { |controller| controller.send(:authenticate_for_permision, "Admin") }, only: [:index]
  def index
		@strain = Strain.all.sample
		@listings = Listing.all.to_gmaps4rails
  end
end
