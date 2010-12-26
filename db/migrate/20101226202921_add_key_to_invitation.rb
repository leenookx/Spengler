class AddKeyToInvitation < ActiveRecord::Migration
  def self.up
    add_column :invitations, :id, :primary_key
  end

  def self.down
    remove_column :invitations, :id
  end
end
