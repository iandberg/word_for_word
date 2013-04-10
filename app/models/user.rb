class User < ActiveRecord::Base
	belongs_to :word
  attr_accessible :email, :password, :username
end
