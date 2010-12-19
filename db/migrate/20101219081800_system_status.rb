class SystemStatus < ActiveRecord::Migration
  def self.up
    create_table :systemstatus, :id => false do |t|
      t.integer :status, :default => 0
    end
  end

  def self.down
    drop_table :systemstatus
  end
end
