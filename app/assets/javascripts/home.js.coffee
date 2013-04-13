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

	$('#home_search').on(
		'click'
		'.autocomplete_link'
		->
			$('#search_input').val(
				$(this).html()			
			)
		)