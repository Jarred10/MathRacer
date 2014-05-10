class User < ActiveRecord::Base
	validates :username, :presence => true, :uniqueness => true
	validates :email, :presence => true, :uniqueness => true;
	validates_confirmation_of :password
	validates_length_of :password, :in => 6..20, :on => :create
	
	def self.authenticate(login_username="", login_password="")
		user = User.find_by_username(login_username)
		if user && user.password == login_password
			return user
		else 
			return false
		end
	end
end
