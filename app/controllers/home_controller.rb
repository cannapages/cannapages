class HomeController < ApplicationController
	# before_filter { |controller| controller.send(:authenticate_for_permision, "Admin") }, only: [:index]
  def index
		@strains = Strain.all.to_a
		@strains.select!{|e| not e.strain_test_ids.empty?}
		@strain = @strains.sample
		
		@listings = Listing.max_near([@user_location.lng,@user_location.lat],50).to_a
		@listings.each do |l|
			l.update_distance( @user_location )
		end

		@specials_listings = @listings.select {|e| e.has_specials?}
		if @specials_listings.size < 4
			@all_special_listings = Listing.all.to_a.select {|e|e.has_specials?}
			@all_special_listings.each do |l|
				@specials_listings.push l unless @specials_listings.include? l
			end
		end
		@featured_listings = @listings.select { |e| e.featured }

		bonus_listings_needed = (3 - @featured_listings.size)
		new_listings_for_featured = @listings.sample( bonus_listings_needed )
		@featured_listings += new_listings_for_featured
		@listings -= @featured_listings
		@featured_listings.each do |l|
			l.update_distance( @user_location )
		end
  end
end
