class WordsController < ApplicationController


	def results
		
		@search_subject = Word.where(:subject => params[:subject]).first
		
		if @search_subject
		
			@list_info = Word.find_by_sql("
					SELECT t1.list_id AS list_id, t2.subject 
					AS list_name 
					FROM word_links AS t1 
					RIGHT JOIN words AS t2 ON t1.list_id = t2.id 
					WHERE t1.subject_id = '#{@search_subject.id}'")
			
			@word_list = WordLink.
				select("words.subject AS the_word, word_links.subject_type AS type").
				where(:list_id => @list_info.first.list_id).
				joins('RIGHT JOIN words ON words.id = word_links.subject_id')

		end

	end



end
