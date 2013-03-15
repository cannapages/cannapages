$(document).ready( function() {
	var user_location = $('user_location')
	var user_lat = parseFloat(user_location.data('lat'))
	var user_lng = parseFloat(user_location.data('lng'))
	var map;
	var markers = [];

	if($("#map").size() > 0) {

		map = L.map('map').setView( [user_lat, user_lng], 12 )
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
		featuredIcon = L.icon({
				iconUrl: '/assets/featured-marker-icon.png',
				// shadowUrl: 'leaf-shadow.png',
				iconSize:     [42, 56]
				// shadowSize:   [50, 64]
				// iconAnchor:   [22, 94]
				// shadowAnchor: [4, 62]
				// popupAnchor:  [-3, -76]
		})
		$('listing').each( function(index,value) {
			value = $(value)
			lat = value.data('lat')
			lng = value.data('lng')
			lat_lng = new L.latLng(lat,lng)
			featured = value.data('featured')
			if( featured ) {
				var marker = L.marker(lat_lng,{icon: featuredIcon}).addTo(map);
			}
			else {
				var marker = L.marker(lat_lng,{icon: mainIcon}).addTo(map);
			}
		})
		
	}
})
