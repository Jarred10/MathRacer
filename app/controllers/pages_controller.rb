class PagesController < ApplicationController

	before_filter :authenticate_user, :only => [:logout]
	before_filter :save_login_state, :only => [:login, :login_attempt, :register]

  def index
  end

  def register
  end

  def play
  end
  
  def login
  end
  
  def login_attempt
  	authorized_user = User.authenticate(params[:login_username],params[:login_password])
  	if authorized_user
  		flash[:notice] = "Logged in."
  		flash[:color] = "valid"
		session[:user_id] = authorized_user.id
  		redirect_to pages_path
	else
   	flash[:notice] = "Invalid Username or Password"
   	flash[:color]= "invalid"
   	render "login"	
  	end
  end
  
	def logout
  		session[:user_id] = nil
  		redirect_to pages_url
	end
end
