$(window).bind( "load", function() {
	var user_location = $('user_location')
	var user_lat = parseFloat(user_location.data('lat'))
	var user_lng = parseFloat(user_location.data('lng'))
	var markers = [];
	var map;

	if($("#map").size() > 0) {

		map = L.map('map').setView( [user_lat, user_lng], 12 )
		L.tileLayer('http://{s}.tile.cloudmade.com/{key}/{styleId}/256/{z}/{x}/{y}.png', {
			key: '5990419e5e434f22be45a5f491ce3e54',
			styleId: 89688,
		}).addTo(map)

		mainIcon = L.icon({
				iconUrl: '/assets/marker-icon.png',
				// shadowUrl: 'leaf-shadow.png',
				iconSize:     [29, 38],
				// shadowSize:   [50, 64]
				iconAnchor:   [13, 34]
				// shadowAnchor: [4, 62]
				// popupAnchor:  [-3, -76]
		})
		featuredIcon = L.icon({
				iconUrl: '/assets/featured-marker-icon.png',
				// shadowUrl: 'leaf-shadow.png',
				iconSize:     [42, 56],
				// shadowSize:   [50, 64]
				iconAnchor:   [17, 51]
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
			marker_text =  "<a href='/listings/" + value.data('slug') + "'>"
			marker_text += "<h3>" + value.data('name') + "</h3>"
			marker_text += "</a>"
			marker_text += "<p>" + value.data('address') + "</p>"
			marker_text += "<p>" + value.data('phone') + "</p>"
			marker.bindPopup(marker_text)
		})
		
	}
	if($("#map2").size() > 0) {
		var reveal_counter = 0;
		map = L.map('map2').setView( [user_lat, user_lng], 12 )
		L.tileLayer('http://{s}.tile.cloudmade.com/{key}/{styleId}/256/{z}/{x}/{y}.png', {
			key: '5990419e5e434f22be45a5f491ce3e54',
			styleId: 89688,
		}).addTo(map)

		mainIcon = L.icon({
				iconUrl: '/assets/marker-icon.png',
				// shadowUrl: 'leaf-shadow.png',
				iconSize:     [29, 38],
				// shadowSize:   [50, 64]
				iconAnchor:   [13, 34]
				// shadowAnchor: [4, 62]
				// popupAnchor:  [-3, -76]
		})
		featuredIcon = L.icon({
				iconUrl: '/assets/featured-marker-icon.png',
				// shadowUrl: 'leaf-shadow.png',
				iconSize:     [42, 56],
				// shadowSize:   [50, 64]
				iconAnchor:   [17, 51]
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
			marker_text =  "<a href='/listings/" + value.data('slug') + "'>"
			marker_text += "<h3>" + value.data('name') + "</h3>"
			marker_text += "</a>"
			marker_text += "<p>" + value.data('address') + "</p>"
			marker_text += "<p>" + value.data('phone') + "</p>"
			marker.bindPopup(marker_text)
		})
		$('.mapit').click( function() {
			reveal_counter += 1
			if( reveal_counter % 2 == 0 ) {
				$('#map2').hide('slow')
			}
			else {
				$('#map2').show('slow')
				setTimeout( function() {map.invalidateSize(true)}, 700 )
			}
		})
	}
})
