# 
# Copyright: Redhat
# Author : Jarred Green
# All Rights Reserved.
#
# Create a class GamesController that parses http requests and calls the methods in this class 
class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy, :join, :leave]
  before_action :authenticate_user, before: :all
  before_action :in_game, before: :all
  before_action :generateQuestion, before: :index

  helper_method :submit_answer			# This method submit the user's answers
  
  # GET /games
  # GET /games.json
  def index
    @opengames = Game.where(:user2 => nil)
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  # Create a new game passing the game parameter, assigning a username to a user1 and keep track of the users progress
  def create
    @game = Game.new(game_params)
	@game.user1 = @current_user.username
	
	@game.user1progress = 0
	@game.user2progress = 0

    # Check if game has been saved then assign the game id to the session id	
    respond_to do |format|
      if @game.save
		session[:game_id] = @game.id
		
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  
 # This method when the user join a game, check is it user1 or user2. If no user then assign each user id to a session
  def join
	if(@game.user1 == nil)
    session[:game_id] = @game.id
    @game.user1 = @current_user.username
    @game.save
    @current_game = @game
	elsif(@game.user2 == nil)
	
    session[:game_id] = @game.id
    @game.user2 = @current_user.username
    @game.save
    @current_game = @game
	else
	flash[:invalid] = 'Game full!'		# Display an error message if the game is full (more than 2 users)
	end
    redirect_to games_url			# Redirect the page to a homepage	
  end
  
  def leave
	@game.destroy
    session[:game_id] = nil
    redirect_to games_url
  end
  
  # This method generate random questions from number 0 to 9
  def generateQuestion
  @f = rand(10)
  @s = rand(10)
  end
  
  # This moethod keep track of the user's answers when game reach 10 questions. Display message to the user if they have won the game
  # Incrementing number of times the user win, then save the game
  def submit_answer
	if(@current_game.user1progress == 10)
	
		flash[:valid] = @current_game.user1 + " won!"
		user1 = User.find_by_username(@current_game.user1)
		user1.wins = user1.wins + 1
		user1.save
		@current_game.destroy
	elsif (@current_game.user2progress == 10)
	
		
		user2 = User.find_by_username(@current_game.user2)
		user2.wins = user2.wins + 1
		user2.save
		
		flash[:valid] = user2.username + " won!"
		@current_game.destroy
	elsif params[:answer].to_f == params[:f].to_f * params[:s].to_f			# Multiply two numbers and assign it to answer parameter
		if(@current_user.username == @current_game.user1)
			@current_game.user1progress = @current_game.user1progress + 1
		else
			@current_game.user2progress = @current_game.user2progress + 1
		end
		
		# Save the game and display the message to the user
		@current_game.save
		flash[:valid] = "Correct Answer!"
	
	else
	
		flash[:invalid] = "Incorrect Answer!"
	
	end
	
		redirect_to games_path			# Redirect the page to the game page
	
	
  
  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:gameid, :user1, :user1progress, :user2, :user2progress)
    end
end
