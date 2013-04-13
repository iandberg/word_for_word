class WordsController < ApplicationController


	def autocomplete
		
		unless params[:subject] == ''
		
			@words = Word.find_by_sql("SELECT subject FROM words WHERE subject LIKE '#{params[:subject]}%'")

			@data = Array.new

			@words.each do |w|		
				@data << "<div class='autocomplete_link'>" + w.subject + "</div>"
			end 
			
		else
		
			@data = Array.new
		end
		
		respond_to do |f|
			f.json { render :json => @data }
		end
		
	end


	def search

		@default_subject = "Fantasy"
		@syllables = ".*"

		if params['subject'] #standard search via home page or results page

			@search_subject = Word.get_subject_record params['subject']
			
			unless params['syllables'] == '' or  params['syllables'].nil? # if no. of syllables given, replace default value
				@syllables = params['syllables']
			end
			
			@list_info = Word.get_lists @search_subject.id
			
			@list_info.each do |i| # if the search term is the same a list, have list be the first one shown
				if i.list_name.downcase == params['subject'].downcase
					@match_found  = "match was found"
					@current_list_id = i.list_id
					@current_list_name = i.list_name
					break
				else #if search term isn't a list name, just use first list in results
					@match_found  = "match was not found"
					@current_list_id = @list_info.first.list_id 
					@current_list_name = @list_info.first.list_name
				end
			end
			
			@word_list = Word.get_results @current_list_id, @syllables
		
		elsif params[:list_subject] #user clicks on list name

			@search_subject = Word.get_subject_record params[:list_subject]
			
			@list_info = Word.get_lists @search_subject.id
			
			@current_list_name = @search_subject.subject
			
			@word_list = Word.get_results @search_subject.id, @syllables

		else

			@search_subject = Word.get_subject_record @default_subject
	
			@list_info = Word.get_lists @search_subject.id
		
			@current_list = @search_subject.subject
		
			@word_list = Word.get_results @search_subject.id, @syllables
		
		end
	end
	
	def get_a_list

			@syllables = ".*"
		
			@search_subject = Word.get_subject_record params[:subject]
			
			@word_list = Word.get_results @search_subject.id, @syllables
		
			unless params[:subject] == ''

				@data = Array.new

				@word_list.each do |l|
					@data << "<div>" + l.the_word + "</div>"
				end
			else
				@data = Array.new
			end
		
		respond_to do |f|
			f.json { render :json => @data }
		end
	end
	
	def new
		@types = WordLink.get_types()
	end		

	def avail_lists
		
		@lists = Word.get_list_names params[:list_search_field]
		
		unless params[:list_search_field] == ''
				
			@data = Array.new
		
			@lists.each do |l|
				@data << "<div class='autocomplete_link'>" + l.subject + "</div>"
			end
		else
			@data = Array.new
		end
		
		respond_to do |f|
			f.json { render :json => @data }
		end
	end
	
	def add_word
	
		
		@new_word = Word.where(:subject => "#{params[:new_word]}").first_or_create(:syllables => "#{params[:syllables]}")
		
		@list_word = Word.get_subject_record params[:list_word]
		
		WordLink.new(:subject_id => "#{@new_word.id}", :list_id => "#{@list_word.id}", :subject_type => "#{params[:subject_type]}").save
		
		render :text => params
		
	end
	
	def index
	
	end
	
	
end
