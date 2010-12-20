class SortOutInvitations < ActiveRecord::Migration
  def self.up
    remove_column :users, :invitation_id

    User.update_all("invitation_limit = 5") 

    add_column :invitations, :email, :string, :null => :false
  end

  def self.down
    add_column :users, :invitation_id, :integer

    remove_column :invitations, :email
  end
end
