# This class control the page, compare user data with a database and only an authenticate user can play. 
# This play login and register links after the user logged out
class PagesController < ApplicationController

	before_filter :authenticate_user, :only => [:play]
	before_filter :logged_out, :only => [:login, :register]

  def index
  end

  def register
  end

  def play
  end
  
  def login
  end
  
end
