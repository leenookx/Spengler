class CopyLinkKeywordsToUserLinks < ActiveRecord::Migration
  def self.up
    execute "update user_links set keywords = (select keywords from links where links.id = user_links.link_id)"
  end

  def self.down
  end
end
