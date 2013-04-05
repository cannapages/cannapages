$(document).ready( function() {
	var slides = $('.special_slider_entry')
	var current_index = 0
	var number_of_slides = slides.size()
	function remove_last() {
		$(slides[index_plus_two()]).hide("slow")
	}
	function remove_first() {
		$(slides[current_index]).hide("slow")
	}
	function add_last() {
		$(slides[index_plus_two()]).show("slow")
	}
	function add_first() {
		$(slides[current_index]).show("slow")
	}
	function index_plus_two() {
		if( current_index + 2 > number_of_slides - 1 ) {
			return current_index + 2 - number_of_slides
		} else {
			return current_index + 2
		}
	}
	function index_plus_one() {
		if( current_index + 1 > number_of_slides - 1 ) {
			return current_index + 1 - number_of_slides
		} else {
			return current_index + 1
		}
	}
	function increment_index() {
		if(current_index == number_of_slides - 1) {
			current_index = 0;
		} else {
			current_index += 1;
		}
	}
	function decrement_index() {
		if(current_index == 0) {
			current_index = number_of_slides - 1;
		} else {
			current_index -= 1;
		}
	}
	function update_classes() {
		$(slides[current_index]).removeClass('middle')
		$(slides[index_plus_one()]).addClass('middle')
		$(slides[index_plus_two()]).removeClass('middle')
	}
	$('.arrow_right').click( function() {
		remove_first()
		increment_index()
		add_last()
		update_classes()
	})
	$('.arrow_left').click( function() {
		remove_last()
		decrement_index()
		add_first()
		update_classes()
	})
})
