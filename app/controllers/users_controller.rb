class UsersController < ApplicationController
	
	def index
	end
		
	def login
	end
	
	def logout
		reset_session
		redirect_to root_path 	
	end
	
	def login_go
		
		@log_status = User.login_process params[:username], params[:password]
		
		if @log_status
			session[:username] = @log_status.username
			redirect_to root_path, :notice => "Welcome!"
		else
			redirect_to users_login_path, :notice => "There were errors"
		end
		
	end
	
	def new
	end
	
	
	def create

		@newuser = User.create(params[:user])
			
		if @newuser.save
			flash[:notice] = "Thanks! Please sign in"
			redirect_to users_login_path
		else
			flash[:notice] = @newuser.errors.full_messages
			redirect_to new_user_path
		end

	end
end
