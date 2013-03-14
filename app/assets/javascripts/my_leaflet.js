$(document).ready( function() {
	var user_location = $('user_location')
	var user_lat = parseInt(user_location.data('lat'))
	var user_lng = parseInt(user_location.data('lng'))
	var max_lat = -90;
	var min_lat = 90;
	var max_lng = -180;
	var min_lng = 180;

	if($("#map").size() > 0) {
		//Get the bounds of the map based on the listings
		$('listing').each( function(index,value) {
			value = $(value)
			lat = value.data('lat')
			lng = value.data('lng')
			
		})

		map = new L.Map("map", {
      center: [user_lat, user_lng],
      zoom: 12
    })
		main_layer = L.tileLayer('http://{s}.tile.cloudmade.com/{key}/{styleId}/256/{z}/{x}/{y}.png', {
			key: '5990419e5e434f22be45a5f491ce3e54',
			styleId: 89663,
		})
		map.addLayer( main_layer )

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
			var marker = L.marker(lat_lng,{icon: mainIcon}).addTo(map);
		})
	}
})
