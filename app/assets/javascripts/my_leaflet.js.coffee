$(document).ready ->
	if $("#map")
		map = L.map('map').setView([51.505, -0.09], 13)
		L.tileLayer('http://{s}.tile.cloudmade.com/{key}/{styleId}/256/{z}/{x}/{y}.png', {
			key: '5990419e5e434f22be45a5f491ce3e54',
			styleId: 89560
		}).addTo(map)
