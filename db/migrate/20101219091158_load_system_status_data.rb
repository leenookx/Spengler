require 'active_record/fixtures'

class LoadSystemStatusData < ActiveRecord::Migration
  def self.up
    directory = File.join(File.dirname(__FILE__), "data")
    Fixtures.create_fixtures(directory, "system_statuses")
  end

  def self.down
    SystemStatus.delete_all
  end
end
