class UsersController < ApplicationController
	
	def index
	end
	
	def login
		@user = User.new
	end
	
	def register
	end
end
