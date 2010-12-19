class CreateActivations < ActiveRecord::Migration
  def self.up
    create_table :activations, :id => false do |t|
      t.string :code, :null => false
      t.integer :user_id

      t.timestamps
    end

    add_index :activations, :code, :unique => true
  end

  def self.down
    drop_table :activations
  end
end
