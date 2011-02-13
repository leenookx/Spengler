xml.instruct!
xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
 xml.channel do

   xml.title       "Spengler RSS Feed for #{@user.name}"
   xml.link        url_for :only_path => false, :controller => 'user', :action => 'feed'
   xml.description "Spengler RSS Feed for #{@user.name}"
   xml.pubDate     CGI.rfc1123_date @user_links.first.updated_at if @user_links.any?

   @user_links.each do |user_link|
     xml.item do
       xml.title       user_link.link.title
       
       tmp = user_link.link.url
       tmp.gsub!("%3A", ":")
       tmp.gsub!("%2F", "/")
       xml.link        tmp
       xml.description user_link.link.description
       xml.guid        12345
       xml.pubDate     CGI.rfc1123_date user_link.link.updated_at
     end
   end
 end
end
