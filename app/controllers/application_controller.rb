class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :isLoggedOut
  helper_method :authenticate_user
  
  def authenticate_user
  		if session[:user_id]
   		 # set current user object to @current_user object variable
   		 @current_user = User.find session[:user_id] 
   		 return true	
  		else
    		return false
  		end
	end
	
	def isLoggedOut
      if session[:user_id]
         return false
      else
         return true
      end
  end
end
