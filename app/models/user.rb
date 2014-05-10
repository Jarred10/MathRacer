class User < ActiveRecord::Base
	validates :username, :presence = true, uniqiuness = true
	validates :email, :presence = true, uniqueness = true;
	validates_length_of :password, :in = 6..20, :on = :create
end
