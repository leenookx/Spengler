class CreateSystemStatuses < ActiveRecord::Migration
  def self.up
    rename_table :systemstatus, :system_statuses
  end

  def self.down
    rename_table :system_statuses, :systemstatus
  end
end
