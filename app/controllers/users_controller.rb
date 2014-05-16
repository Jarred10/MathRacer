# 
# Copyright: Redhat
# Author : Jarred Green
# All Rights Reserved.
#
# Create a class UserController that parses http requests and calls the methods in this class
class UsersController < ApplicationController
 # Before the specified methods, call the set user function
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :logged_out, :only => [:new, :create]
  before_filter :authenticate_user, only: [:edit, :update, :destroy]
  # Logout is accessible from all pages	
  helper_method :logout
  
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
	@user.wins = 0

    respond_to do |format|
      if @user.save
        flash[:valid] = 'Registration was successful.'
        format.html { redirect_to pages_url}
        format.json { render :show, status: :created, location: index }
      else
        format.html { render 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:valid] = 'Update was successful.'
        format.html { redirect_to @user}
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    session[:user_id] = nil # Set the user_id session variable to nil
    respond_to do |format|
      flash[:valid] = 'User was successfully destroyed.'
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end

  # Authenticates a user that attempts to login
  def login_attempt
    # Authenticates a user with the posted parameters and stores the user if they exist, otherwise stores nil	
    authorized_user = User.authenticate(params[:login_username],params[:login_password])
    # If the user exists in the database
    if authorized_user
    	# Display logged in message
      flash[:valid] = "Logged in."
      # Store user id in a session variable
      session[:user_id] = authorized_user.id
      # Redirect to home page
      redirect_to pages_url
    else # Else the user doesn't exist
    	# Display error message
      flash[:invalid] = "Invalid Username or Password"
      # Reload the page
      render "login"
    end
  end

  # Sets the session variables for user and game to nil, then redirects to the home page	
  def logout
    session[:user_id] = nil
	session[:game_id] = nil
    redirect_to pages_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email)
  end
end

