class HomeController < ApplicationController
	# before_filter { |controller| controller.send(:authenticate_for_permision, "Admin") }, only: [:index]
  def index
		@strain = Strain.one_randome.first
		@listings = Listing.near([@user_location.lat,@user_location.lng],50)
		@featured_listings = @listings.where(city: @user_location.city).featured(3)
  end
end
