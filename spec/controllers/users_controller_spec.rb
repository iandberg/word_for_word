require "spec_helper"

describe UsersController do

	describe "GET user 'login'" do
	
		it "should be successful" do
			get 'login'
			response.should be_success
		end
		
	end
	
	
	
end