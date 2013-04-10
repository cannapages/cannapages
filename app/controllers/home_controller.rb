class HomeController < ApplicationController
  def index
		current = Time.now
		@strains = Strain.all.to_a
		@strains.select!{|e| not e.strain_test_ids.empty?}
		@strain = @strains.sample
		puts "Strains: #{Time.now - current}"
		current = Time.now		


		@listings = Listing.max_near([@user_location.lng,@user_location.lat],50).to_a
		@listings.each do |l|
			l.update_distance( @user_location )
		end
		puts "Listings: #{Time.now - current}"
		current = Time.now		

		@specials_listings = @listings.select {|e| e.has_specials?}
		if @specials_listings.size < 4
			@all_special_listings = Listing.all.to_a.select {|e|e.has_specials?}
			@all_special_listings.each do |l|
				@specials_listings.push l unless @specials_listings.include? l
			end
		end
		puts "Specials: #{Time.now - current}"
		current = Time.now		
		@featured_listings = @listings.select { |e| e.featured }
		puts "Featured: #{Time.now - current}"
		current = Time.now		

		bonus_listings_needed = (3 - @featured_listings.size)
		new_listings_for_featured = @listings.sample( bonus_listings_needed )
		@featured_listings += new_listings_for_featured
		@listings -= @featured_listings
		@featured_listings.each do |l|
			l.update_distance( @user_location )
		end
		puts "Extra Featured: #{Time.now - current}"
		current = Time.now		
  end
end
