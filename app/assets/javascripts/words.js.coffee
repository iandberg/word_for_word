# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	
	$('#result_tabs').tabs()
	
	avail_lists = $('#avail_lists')
	
	$('#list_search_field').keyup ->
		$.post(
			avail_lists.attr('action')
			avail_lists.serialize()
			(data) ->
				$('#list_results').html(data)
			'json')
	

	$('#list_results').on(
		"click"
		".autocomplete_link"
		->
			search_term = $(this).html()
			
			$.get(
				'/words/get_a_list?subject=' + search_term
				(data) ->
					$('#list').html(data)
					$('[name=list_word]').val(search_term)
				'json')
		)