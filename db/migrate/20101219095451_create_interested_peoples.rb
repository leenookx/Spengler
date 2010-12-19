class CreateInterestedPeoples < ActiveRecord::Migration
  def self.up
    create_table :interested_peoples do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :email, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :interested_peoples
  end
end
