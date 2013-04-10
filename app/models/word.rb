class Word < ActiveRecord::Base
  has_many :wordlinks, :foreign_key => "subject_id",
  	:class_name => "WordLink"
  	
  has_many :words, :through => :wordlinks
  attr_accessible :subject, :syllables, :user_id
end
