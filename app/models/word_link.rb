class WordLink < ActiveRecord::Base
	belongs_to :word, :foreign_key => "subject_id", :class_name => "Word"
	belongs_to :word, :foreign_key => "list_id", :class_name => "Word"
	attr_accessible :list_id, :subject_id, :subject_type


	def self.get_types
		self.find_by_sql("
			SELECT DISTINCT subject_type FROM word_links
		")
	end
	

end
