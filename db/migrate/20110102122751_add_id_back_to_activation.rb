class AddIdBackToActivation < ActiveRecord::Migration
  def self.up
    add_column :activations, :id, :integer
    change_column :activations, :id, :primary_key
  end

  def self.down
    remove_column :activations, :id
  end
end
