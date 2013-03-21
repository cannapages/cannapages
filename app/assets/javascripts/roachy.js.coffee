jQuery ->
	class Roachy

		constructor: ->
			@indexMode = false
			@current = 1
			@lessons = $('.roachy-lesson')
			@indexLinks = $('.roachy-index-link')
			@numOfLessons = @lessons.size()
		handleIndex: ->
			@indexMode = false
			@current = 1
			@deactivate @lessons.eq( @numOfLessons - 1 )
			@activate @lessons.eq( 0 )

		next: ->
			if @indexMode
				@handleIndex()
				return true
			@deactivate @lessons.eq(@current - 1)
			@incr()
			@activate @lessons.eq(@current - 1)
		previous: ->
			if @indexMode
				@handleIndex()
				return true
			@deactivate @lessons.eq(@current - 1)
			@decr()
			@activate @lessons.eq(@current - 1)

		incr: ->
			@current = if @current == @numOfLessons - 1 then 1 else @current + 1
		decr: ->
			@current = if @current == 1 then @numOfLessons - 1 else @current - 1

		activate: (lesson) ->
			lesson.removeClass( 'roachy-inactive' )
			lesson.addClass( 'roachy-active' )
		deactivate: (lesson) ->
			lesson.addClass( 'roachy-inactive' )
			lesson.removeClass( 'roachy-active' )

		index: ->
			@deactivate @lessons.eq(@current - 1)
			@activate @lessons.eq( @numOfLessons - 1 )
			@indexMode = true
		indexClick: (indexLink) ->
			@handleIndex()
			@deactivate @lessons.eq( @current - 1)
			@current = parseInt indexLink.attr('id').split('-')[3]
			@activate @lessons.eq( @current - 1)

	roachy = new Roachy

	$('#roachy-btn-next').click ->
		roachy.next()
	$('#roachy-btn-previous').click ->
		roachy.previous()
	$('#roachy-btn-index').click ->
		roachy.index()
	$('.roachy-index-link').click ->
		roachy.indexClick( $(this) )

