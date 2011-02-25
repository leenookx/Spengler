class RemoveKeywordsFromLinks < ActiveRecord::Migration
  def self.up
    remove_column :links, :keywords
  end

  def self.down
    add_column :links, :keywords, :string
  end
end
