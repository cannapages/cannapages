class HomeController < ApplicationController
	# before_filter { |controller| controller.send(:authenticate_for_permision, "Admin") }, only: [:index]
  def index
		@strain = Strain.one_randome.first
		@listings = Listing.near([@user_location.lng,@user_location.lat],50).to_a
		@featured_listings = @listings.select { |e| e.featured }
		@listings -= @featured_listings
		bonus_listings_needed = (3 - @featured_listings.size)
		new_listings_for_featured = @listings.sample( bonus_listings_needed )
		@featured_listings += new_listings_for_featured
		@listings -= @featured_listings
		@featured_listings.each do |l|
			l.update_distance( @user_location )
		end
  end
end
