class User < ActiveRecord::Base
# 	belongs_to :word
	attr_accessible :username, :email, :password, :password_confirmation
  
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  
  validates :username, :email, :password, :password_confirmation, :presence => true
  validates :email, :format => { :with => email_regex }
  validates :password, :confirmation => true


	def self.login_process name, password
	
		@user = User.where("username = '#{name}' AND password = '#{password}'")
		
		if @user.exists?
			@user.first
		else
			false
		end
		
# 		User.where("username = 'ian' AND password = 'psword'").exists?
	end

end


