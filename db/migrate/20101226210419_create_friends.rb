class CreateFriends < ActiveRecord::Migration
  def self.up
    create_table :friends do |t|
      t.integer :from
      t.integer :to
      t.timestamps
    end
  end

  def self.down
    drop_table :friends
  end
end
