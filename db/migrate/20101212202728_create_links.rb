class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.text :url, :null => false
      t.text :description
      t.string :keywords
      t.integer :status, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
