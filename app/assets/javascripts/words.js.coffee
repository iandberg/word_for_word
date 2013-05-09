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
	
	
	$('#avail_lists').submit (event) ->
		event.preventDefault()
	
	$('#list_results').on(
		"click"
		".autocomplete_link"
		->
			event.stopPropagation()

			search_term = $(this).html()

			$('#list_search_field').val(
				search_term		
			)
			
			$.get(
				'/words/get_a_list?subject=' + search_term
				(data) ->
					$('#list').html(data)
					$('[name=list_word]').val(search_term)
					$('#new_word_submit').prop('disabled', false)
				'json')
		)
		
	$(document).click ->
		$('#list_results').html('')
	
	$('#new_word').on(
		"submit"
		->
			$('#thank_you').html('')
			$('#thank_you').show()
			
			form = $(this)
			
			$.post(
				form.attr('action')
				form.serialize()
				(data) ->
					console.log(data)
					$('#thank_you').html(data.thanks)
					$('#thank_you').fadeOut(4000)

				'json')
			return false;
		)

	$('.clipboard').click (e) ->
		e.stopPropagation()
		text = $(this).parent().children('li').children('a')
		results = new Array()
		text.each ->
			results.push this.innerHTML
		window.prompt "Ctrl/Cmnd+C to copy to clipboard", results.toString().replace /,/g,'\r'

		
		