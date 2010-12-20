class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations, :id => false do |t|
      t.integer :user_id
      t.string :code, :null => false
      t.timestamps
    end

    add_index :invitations, :code
  end

  def self.down
    drop_table :invitations
  end
end
