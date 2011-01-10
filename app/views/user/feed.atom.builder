atom_feed do |feed|
  feed.title( "Feed for #{@user.name}" )
  feed.updated( @user_links.first.updated_at )

  for user_link in @user_links
    feed.entry( user_link.link ) do |entry|
      entry.title( user_link.link.title )
      entry.content( "" )
      entry.updated( user_link.updated_at )
    end
  end
end
