class AddUserInfo < ActiveRecord::Migration
  def self.up
    add_column :users, :forename, :string
    add_column :users, :surname, :string
  end

  def self.down
    remove_column :users, :forename
    remove_column :users, :surname
  end
end
