require 'spec_helper'

describe User do

	it "has a username and password" do
	
		newuser = User.new(	:username => 'Firstly', 
							:email => 'firstly@mclastname.com',
							:password => 'password',
							:password_confirmation => 'password')
		
		expect(newuser).to be_valid
		
	end

	it "should be invalid without username" do
		expect(User.new( :username => nil)).to have(1).errors_on(:username)
	end
	
	it "should have valid email address" do
		expect(User.new( :email => 'ian@dahlby')).to have(1).errors_on(:email)
	end
	
end