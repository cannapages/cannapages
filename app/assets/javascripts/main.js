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
		map = L.map('listing_show_map').setView( [lat + .001, lng - .003], 17 )
		L.tileLayer('http://{s}.tile.cloudmade.com/{key}/{styleId}/256/{z}/{x}/{y}.png', {
			key: '5990419e5e434f22be45a5f491ce3e54',
			styleId: 89688,
		}).addTo(map)

		mainIcon = L.icon({
				iconUrl: '/assets/listing-show-map-icon.png',
				// shadowUrl: 'leaf-shadow.png',
				iconSize:     [125, 167],
				// shadowSize:   [50, 64]
				iconAnchor:   [48, 160]
				// shadowAnchor: [4, 62]
				// popupAnchor:  [-3, -76]
		})
		var marker = L.marker([lat,lng],{icon: mainIcon}).addTo(map);
	}
})
$(document).ready( function() {
	$("#product_price_ounce").blur( function() {
		var ounce_price = parseFloat($("#product_price_ounce").val())
		if(! isNaN(ounce_price) ) {
			$("#product_price_1_2").val( ounce_price / 2 )
			$("#product_price_1_4").val( ounce_price / 4 )
			$("#product_price_1_8").val( ounce_price / 8 )
			$("#product_price_1_16").val( ounce_price / 16 )
		}
	})
})
$(document).ready( function() {
	$("#show_product_form").click( function() {
		product_form = $("#new_product")
		if( product_form.css("display") == 'none' ) {
			product_form.show("slow")
		} else {
			product_form.hide("slow")
		}
	})
})


