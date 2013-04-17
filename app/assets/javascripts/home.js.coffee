# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

	form = $('#live_search')
	
	$('#search_input').keyup ->
		$.post(
			'/words/autocomplete'
			form.serialize()
			(data) ->
				console.log data
				$('#home_search_results').html(data)
			'json')
	
	$(document).click ->
		$('#home_search_results').html('')
	
	$('#home_search').on(
		'click'
		'.autocomplete_link'
		->
			event.stopPropagation()
			
			$('#search_input').val(
				$(this).text()		
			)
		)
		
	$(document).keydown (e) ->
	
		if e.keyCode == 38
			words = $('.autocomplete_link').length
			if words > 0
				$("#home_search_results div:first-child").addClass('selected')
			e.preventDefault()
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		