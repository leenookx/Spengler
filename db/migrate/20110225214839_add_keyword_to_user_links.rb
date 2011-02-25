class AddKeywordToUserLinks < ActiveRecord::Migration
  def self.up
    add_column :user_links, :keywords, :string
  end

  def self.down
    remove_column :users_links, :keywords
  end
end
