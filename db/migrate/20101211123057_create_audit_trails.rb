class CreateAuditTrails < ActiveRecord::Migration
  def self.up
    create_table :audit_trails do |t|
      t.integer :user_id, :null => false
      t.string :log_entry, :default => ""
      t.timestamps
    end
  end

  def self.down
    drop_table :audit_trails
  end
end
