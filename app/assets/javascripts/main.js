//This document is for small things like the image switcher for the field guid show page
$(document).ready(function() {
	if( ($('.large_holder').size() > 0) && ( $('.small_holder').size() > 0) ) {
		$('.small_holder').click( function() {
			new_image = $(this).find('img').data('src')
			$('.large_holder').find('img').attr('src',new_image)
		})
	}
})
