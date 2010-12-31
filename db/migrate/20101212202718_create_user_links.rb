class CreateUserLinks < ActiveRecord::Migration
  def self.up
    create_table :user_links, :id => false do |t|
      t.integer :user_id
      t.integer :link_id
      t.timestamps
    end
  end

  def self.down
    drop_table :user_links
  end
end
