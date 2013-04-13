class User < ActiveRecord::Base
	belongs_to :word
  attr_accessible :email, :password, :password_confirmation, :username
  
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  
  validates :username, :email, :password, :password_confirmation, :presence => true
  validates :email, :format => { :with => email_regex }
  validates :password, :confirmation => true
end
