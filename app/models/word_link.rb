class WordLink < ActiveRecord::Base
	belongs_to :word, :foreign_key => "subject_id", :class_name => "Word"
	belongs_to :word, :foreign_key => "list_id", :class_name => "Word"
	attr_accessible :list_id, :subject_id, :subject_type
end
