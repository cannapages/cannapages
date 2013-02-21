class HomeController < ApplicationController
	# before_filter { |controller| controller.send(:authenticate_for_permision, "Admin") }, only: [:index]
  def index
		@strain = Strain.one_randome.first
		@listings = Listing.all.to_a
		@map_listings = @listings.to_gmaps4rails
		@featured_listings = @listings.inject([]) {|r,l| l.featured ? (r << l) : r}
		@featured_listings= @featured_listings.sample(3).shuffle
  end
end
