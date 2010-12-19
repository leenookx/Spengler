class Avatar < ActiveRecord::Base
  # Image directories
  if ENV["RAILS_ENV"] == "test"
    URL_STUB = DIRECTORY = "tmp"
  elsif ENV["RAILS_ENV"] == "development"
    URL_STUB = "/images/avatars"
    DIRECTORY = File.join("public", "images", "avatars")
  else
    URL_STUB = "/images/avatars"
    DIRECTORY = File.join("images", "avatars")
  end

  def initialize(user, image = nil)
    @user = user
    @image = image
  end

  def exists?
    File.exists?(File.join(DIRECTORY, filename))
  end

  alias exist? exists?

  def url
    avatar_name = exists? ? filename : "empty_avatar.jpg"
    "#{URL_STUB}/#{avatar_name}"
  end

  def thumbnail_url
    thumb = exists? ? thumbnail_name : "empty_avatar_thumbnail.png"
    "#{URL_STUB}/#{thumb}"
  end

  # Delete the users avatar picture
  def delete
    [filename, thumbnail_name].each do |name|
      image = "#{DIRECTORY}/#{name}"
      File.delete(image) if File.exists?(image)
    end
  end

private

  # Return the filename of the main avatar
  def filename
    "#{@user.name}.png"
  end

  # Return the filename of the avatar thumbnail
  def thumbnail_name
    "#{@user.name}_thumbnail.png"
  end
end
