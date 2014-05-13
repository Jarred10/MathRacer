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
