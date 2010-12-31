class AddAuthenticationCodeToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :authentication_code, :string
  end

  def self.down
    remove_column :users, :authentication_code
  end
end
