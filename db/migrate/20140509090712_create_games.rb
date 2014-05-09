class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :gameid
      t.string :user1
      t.integer :user1progress
      t.string :user2
      t.integer :user2progress

      t.timestamps
    end
  end
end
