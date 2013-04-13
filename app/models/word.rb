class Word < ActiveRecord::Base
  has_many :wordlinks, :foreign_key => "subject_id",
  	:class_name => "WordLink"
  	
  has_many :words, :through => :wordlinks
  attr_accessible :subject, :syllables, :user_id
  
  
  
  
	def create_link
	
		
	end
	  
    
  
  	def self.get_subject_record subject
	
		Word.where(:subject => subject).first
	
	end

	def self.get_lists subject_id
	
			Word.find_by_sql("
				SELECT	t1.list_id AS list_id,
						t2.subject AS list_name 
				FROM word_links AS t1 
				RIGHT JOIN words AS t2 ON t1.list_id = t2.id 
				WHERE t1.subject_id = '#{subject_id}'")
	end

	#by default, we look for any syllables, but can optionally pass in syllable number
  
  	def self.get_results subject_id, syllables
	
			WordLink.find_by_sql("
				SELECT	t2.subject AS the_word,
						t1.subject_type AS type
				FROM word_links AS t1
				JOIN words AS t2 ON t1.subject_id = t2.id
				WHERE t1.list_id = '#{subject_id}'
				AND t2.syllables REGEXP '#{syllables}'")
	end

	def self.get_list_names letters
	
		Word.find_by_sql("
			SELECT DISTINCT t2.subject
			FROM word_links AS t1
			JOIN words AS t2 ON t1.list_id = t2.id
			WHERE t2.subject LIKE '#{letters}%'
			")
		
	end
  
end
