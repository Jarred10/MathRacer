# Class defines a user, validates username, email, password and the length of password is between 6 t0 20 digits
class User < ActiveRecord::Base
	# Checks the username is provided and is unique
	validates :username, :presence => true, :uniqueness => true
	# Checks the email is provided and is unique
	validates :email, :presence => true, :uniqueness => true;
	# Checks that the two passwords provided match
	validates_confirmation_of :password
	# Checks the password is an acceptable length
	validates_length_of :password, :in => 6..20, :on => :create
	
	# Authenticate a users log in attempt by comparing their username and password against the database
	def self.authenticate(login_username="", login_password="")
		# Grab the user
		user = User.find_by_username(login_username)
		# If the user exists and passwords match
		if user && user.password == login_password
			# Return that user
			return user
		# Else
		else 
			# Return false to invalidate the login
			return false
		end
	end
end
