class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email
	  t.integer :wins, :default => 0

      t.timestamps
    end
  end
end
