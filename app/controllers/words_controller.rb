class WordsController < ApplicationController

	def search

		@default_subject = "Fantasy"
		@syllables = ".*"

		if params['subject'] #standard search via home page or results page

			@search_subject = get_subject_record params['subject']
			
			unless params['syllables'] == '' or  params['syllables'].nil?# if no. of syllables given, replace default value
				@syllables = params['syllables']
			end
			
			@list_info = get_lists @search_subject.id
			
			@list_info.each do |i| # if the search term is the same a list, have list be the first one shown
				if i.list_name.downcase == params['subject']
					@current_list_id = i.list_id
					@current_list_name = i.list_name
					break
				else #if search term isn't a list name, just use first list in results
					@current_list_id = @list_info.first.list_id 
					@current_list_name = @list_info.first.list_name
				end
			end
			
			@word_list = get_results @current_list_id, @syllables
		
		elsif params['list_subject'] #user clicks on list name

			@search_subject = get_subject_record params['list_subject']
			
			@list_info = get_lists @search_subject.id
			
			@current_list_name = @search_subject.subject
			
			@word_list = get_results @search_subject.id, @syllables

		else

			@search_subject = get_subject_record @default_subject
	
			@list_info = get_lists @search_subject.id
		
			@current_list = @search_subject.subject
		
			@word_list = get_results @search_subject.id, @syllables
		
		end
	end
	
	def get_subject_record subject
	
		Word.where(:subject => subject).first
	
	end
	
	def get_lists subject_id
	
			Word.find_by_sql("
				SELECT	t1.list_id AS list_id,
						t2.subject AS list_name 
				FROM word_links AS t1 
				RIGHT JOIN words AS t2 ON t1.list_id = t2.id 
				WHERE t1.subject_id = '#{subject_id}'")
	end

	#by default, we look for any syllables, but can optionally pass in syllable number
	def get_results subject_id, syllables
	
			WordLink.find_by_sql("
				SELECT	t2.subject AS the_word,
						t1.subject_type AS type
				FROM word_links AS t1
				JOIN words AS t2 ON t1.subject_id = t2.id
				WHERE t1.list_id = '37'
				AND t2.syllables REGEXP '#{syllables}'")
	end
	
	def index
	end
	
end
