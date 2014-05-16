# Class defines schema for users table in the database
class CreateUsers < ActiveRecord::Migration
  def change
    # Create a table of users, for each user
    create_table :users do |t|
      # Make a string for the username
      t.string :username
      # Make a string for the password
      t.string :password
      # Make a string for the email
      t.string :email
      # Make an integer for wins count tracking, default it to 0
      t.integer :wins, :default => 0

      t.timestamps
    end
  end
end
