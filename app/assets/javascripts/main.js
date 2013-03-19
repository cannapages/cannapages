//This document is for small things like the image switcher for the field guid show page
$(document).ready(function() {
	if( ($('.large_holder').size() > 0) && ( $('.small_holder').size() > 0) ) {
		$('.small_holder').click( function() {
			new_image = $(this).find('img').data('src')
			$('.large_holder').find('img').attr('src',new_image)
		})
	}
})
$(window).bind( "load", function() {
	if($("#listing_show_map").size() > 0) {
		listing = $('listing').first()
		lat = listing.data('lat')
		lng = listing.data('lng')
		map = L.map('listing_show_map').setView( [lat, lng - .003], 17 )
		L.tileLayer('http://{s}.tile.cloudmade.com/{key}/{styleId}/256/{z}/{x}/{y}.png', {
			key: '5990419e5e434f22be45a5f491ce3e54',
			styleId: 89688,
		}).addTo(map)

		mainIcon = L.icon({
				iconUrl: '/assets/marker-icon.png',
				// shadowUrl: 'leaf-shadow.png',
				iconSize:     [29, 38]
				// shadowSize:   [50, 64]
				// iconAnchor:   [22, 94]
				// shadowAnchor: [4, 62]
				// popupAnchor:  [-3, -76]
		})
		var marker = L.marker([lat,lng],{icon: mainIcon}).addTo(map);
	}
})
