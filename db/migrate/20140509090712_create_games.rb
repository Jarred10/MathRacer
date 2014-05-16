# creates a class to create the games table
class CreateGames < ActiveRecord::Migration
  def change
    # create a table for games
    create_table :games do |t|
      # id for the game
      t.string :gameid
      # the username for user1
      t.string :user1
      # the amount of correct questions answered by user1
      t.integer :user1progress
       # the username for user2
      t.string :user2
      # the amount of correct questions answered by user2
      t.integer :user2progress
      t.timestamps
    end
  end
end
