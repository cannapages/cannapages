//This document is for small things like the image switcher for the field guid show page
$(document).ready(function() {
	if( ($('.large_holder').size() > 0) && ( $('.small_holder').size() > 0) ) {
		$('.small_holder').click( function() {
			new_image = $(this).find('img').data('src')
			$('.large_holder').find('img').attr('src',new_image)
		})
	}
	$("#location_change").click( function() {
		$("#search_user_location").focus()
	})
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
$(document).ready( function() {
	function update_article_add_url( col_num, slug ) {
		link = $("#add_articles_to_volume_link")
		parts = link.attr('href').split("/")
		index = 3 + col_num
		parts[index] = slug
		new_link = parts.join("/")
		link.attr('href',new_link)
	}

	$("#add_article_to_col1").change( function() {
		selection = $(this).find(":selected")
		slug = selection.attr('slug')
		update_article_add_url( 1, slug )
	})
	$("#add_article_to_col2").change( function() {
		selection = $(this).find(":selected")
		slug = selection.attr('slug')
		update_article_add_url( 2, slug )
	})
	$("#add_article_to_col3").change( function() {
		selection = $(this).find(":selected")
		slug = selection.attr('slug')
		update_article_add_url( 3, slug )
	})
})

$(document).ready( function() {
	var num_of_slides = $(".critiques_slider_top .slide").size()
	var main_slider_current_index = 0
	function slide_for_index(index) {
		left_hand = ".critiques_slider_top .slide[index='"
		middle = index
		right_hand = "']"
		search_string = left_hand + middle + right_hand
		return $(search_string)
	}
	function remove_current() {
		$(slide_for_index( main_slider_current_index )).hide("slow")
	}
	function add_currrent() {
		$(slide_for_index( main_slider_current_index )).show("slow")
	}
	$(".critiques_slider_top .arrow_right").click( function() {
		remove_current()
		if( main_slider_current_index == num_of_slides - 1 ) {
			main_slider_current_index = 0
		} else {
			main_slider_current_index += 1
		}
		add_currrent()
	})
	$(".critiques_slider_top .arrow_left").click( function() {
		remove_current()
		if( main_slider_current_index == 0 ) {
			main_slider_current_index = num_of_slides - 1
		} else {
			main_slider_current_index -= 1
		}
		add_currrent()
	})
})

$(document).ready( function() {
	var num_of_slides = $(".critiques_slider2 .slide").size()
	var current_index = 0
	$(".critiques_slider .arrow_left").click( function() {
		$(".critiques_slider .slide").each( function( element ) {
			if( $(this).attr('current') == "true" ) {
				if( current_index - 1 < 0 ) {
					current_index = num_of_slides - 1
				} else {
					current_index -= 1
				}
				$(this).attr('current',"false")
				$(this).hide("slow")
			}
		})
		$(".critiques_slider .slide").each( function( element ) {
			if($(this).attr('index') == current_index) {
				$(this).attr('current',"true")
				$(this).show("slow")
			}
		})
	})
	$(".critiques_slider .arrow_right").click( function() {
		$(".critiques_slider .slide").each( function( element ) {
			if( $(this).attr('current') == "true" ) {
				if( current_index + 1 > num_of_slides - 1 ) {
					current_index = 0
				} else {
					current_index += 1
				}
				$(this).attr('current',"false")
				$(this).hide("slow")
			}
		})
		$(".critiques_slider .slide").each( function( element ) {
			if($(this).attr('index') == current_index) {
				$(this).attr('current',"true")
				$(this).show("slow")
			}
		})
	})
})

$(document).ready( function() {
	var num_of_slides = $(".slider_right_container .slider1 .green_thingy").size()
	var current_index = 0
	$(".slider_right_container .slider1 .arrow_left").click( function() {
		$(".slider_right_container .slider1 .green_thingy").each( function( element ) {
			if( $(this).attr('current') == "true" ) {
				if( current_index - 1 < 0 ) {
					current_index = num_of_slides - 1
				} else {
					current_index -= 1
				}
				$(this).attr('current',"false")
				$(this).hide("slow")
			}
		})
		$(".slider_right_container .slider1 .green_thingy").each( function( element ) {
			if($(this).attr('index') == current_index) {
				$(this).attr('current',"true")
				$(this).show("slow")
			}
		})
	})
	$(".slider_right_container .slider1 .arrow_right").click( function() {
		$(".slider_right_container .slider1 .green_thingy").each( function( element ) {
			if( $(this).attr('current') == "true" ) {
				if( current_index + 1 > num_of_slides - 1 ) {
					current_index = 0
				} else {
					current_index += 1
				}
				$(this).attr('current',"false")
				$(this).hide("slow")
			}
		})
		$(".slider_right_container .slider1 .green_thingy").each( function( element ) {
			if($(this).attr('index') == current_index) {
				$(this).attr('current',"true")
				$(this).show("slow")
			}
		})
	})
})

$(document).ready( function() {
	var num_of_slides = $(".slider_right_container .slider2 .green_thingy").size()
	var current_index = 0
	$(".slider_right_container .slider2 .arrow_left").click( function() {
		$(".slider_right_container .slider2 .green_thingy").each( function( element ) {
			if( $(this).attr('current') == "true" ) {
				if( current_index - 1 < 0 ) {
					current_index = num_of_slides - 1
				} else {
					current_index -= 1
				}
				$(this).attr('current',"false")
				$(this).hide("slow")
			}
		})
		$(".slider_right_container .slider2 .green_thingy").each( function( element ) {
			if($(this).attr('index') == current_index) {
				$(this).attr('current',"true")
				$(this).show("slow")
			}
		})
	})
	$(".slider_right_container .slider2 .arrow_right").click( function() {
		$(".slider_right_container .slider2 .green_thingy").each( function( element ) {
			if( $(this).attr('current') == "true" ) {
				if( current_index + 1 > num_of_slides - 1 ) {
					current_index = 0
				} else {
					current_index += 1
				}
				$(this).attr('current',"false")
				$(this).hide("slow")
			}
		})
		$(".slider_right_container .slider2 .green_thingy").each( function( element ) {
			if($(this).attr('index') == current_index) {
				$(this).attr('current',"true")
				$(this).show("slow")
			}
		})
	})
})

$(document).ready( function() {
	var num_of_slides = $(".cadets_grave .grave").size()
	var main_slider_current_index = 0
	function slide_for_index(index) {
		left_hand = ".cadets_grave .grave[index='"
		middle = index
		right_hand = "']"
		search_string = left_hand + middle + right_hand
		return $(search_string)
	}
	function remove_current() {
		$(slide_for_index( main_slider_current_index )).hide("slow")
	}
	function add_currrent() {
		$(slide_for_index( main_slider_current_index )).show("slow")
	}
	$(".cadets_grave .arrow_right").click( function() {
		remove_current()
		if( main_slider_current_index == num_of_slides - 1 ) {
			main_slider_current_index = 0
		} else {
			main_slider_current_index += 1
		}
		add_currrent()
	})
	$(".cadets_grave .arrow_left").click( function() {
		remove_current()
		if( main_slider_current_index == 0 ) {
			main_slider_current_index = num_of_slides - 1
		} else {
			main_slider_current_index -= 1
		}
		add_currrent()
	})
})
