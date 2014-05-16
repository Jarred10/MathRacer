# Core controller for the application
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # Share these methods with subclasses
  helper_method :logged_out
  helper_method :authenticate_user
  helper_method :in_game
  helper_method :in_full_game
  
  # Authenticates a users log in
  def authenticate_user
  	# If the session matches the users id
  	if session[:user_id]
   		# Set current user object to @current_user object variable
   		@current_user = User.find session[:user_id] 
   		# Return true so we know they were succesfully authenticated
   		return true
   	# Else the user cannot be authenticated
  	else
  		# So return false
    		return false
  	end
  end
	
  # Checks if a user is logged out
  def logged_out
      # If a session is set
      if session[:user_id]
      	 # Return false because they are logged in
         return false
      # Else
      else
      	 # No one is logged in so return true
         return true
      end
  end
  
  # Checks if the user is ingame
  def in_game
    # If the session is set
    if session[:game_id]
    	        # If a game exists for that user
		if (Game.exists?(session[:game_id]))
			# Set the current game variable to point to that game
			@current_game = Game.find(session[:game_id])
			# Return true
			return true
		# Else
		else
			# Nil the sessions game id
			session[:game_id] = nil
			# Return false because you aren't ingame
			return false
		end
    end
  end
  
  # Checks if the user is in a full game
  def in_full_game
    # Return if the user is ingame and there is a second user
    return in_game && @current_game.user2 != nil
  end
end
