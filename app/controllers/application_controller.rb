class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :logged_out
  helper_method :authenticate_user
  helper_method :in_game
  helper_method :in_full_game
  
  def authenticate_user
  		if session[:user_id]
   		 # set current user object to @current_user object variable
   		 @current_user = User.find session[:user_id] 
   		 return true	
  		else
    		return false
  		end
	end
	
	def logged_out
      if session[:user_id]
         return false
      else
         return true
      end
  end
  
  def in_game
    if session[:game_id]
		if (Game.exists?(session[:game_id]))
			@current_game = Game.find(session[:game_id])
			return true
		else
			session[:game_id] = nil
			return false
		end
    end
  end
  
  def in_full_game
    return in_game && @current_game.user2 != nil
  end
end
