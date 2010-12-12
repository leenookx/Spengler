require 'sha1'

class User < ActiveRecord::Base
  NAME_MIN_LENGTH = 4
  NAME_MAX_LENGTH = 20
  EMAIL_MIN_LENGTH = 10
  EMAIL_MAX_LENGTH = 50
  PASSWORD_MIN_LENGTH = 4
  PASSWORD_MAX_LENGTH = 40

  NAME_RANGE = NAME_MIN_LENGTH..NAME_MAX_LENGTH
  EMAIL_RANGE = EMAIL_MIN_LENGTH..EMAIL_MAX_LENGTH
  PASSWORD_RANGE = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH

  NAME_SIZE = 20
  PASSWORD_SIZE = 20
  EMAIL_SIZE = 30

  validates_uniqueness_of :name 
  validates_confirmation_of :password, :on => :create, :if =>lambda { |user| user.new_record? or not user.password.blank? }
  validates_length_of :name, :within => NAME_RANGE
  validates_length_of :email, :within => EMAIL_RANGE
  validates_length_of :password, :within => PASSWORD_RANGE, :if =>lambda { |user| user.new_record? or not user.password.blank? }

  validates_format_of     :name,
                          :with => /^[A-Z0-9_]*$/i,
                          :message => "must contain only letters, " +
                                      "numbers, and underscores."
  validates_format_of     :email,
                          :with => /^[A-Z0-9._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i,
                          :message => "must be a valid email address."

  # Create an attribute that isn't in the database.
  attr_accessor :remember_me

  attr_accessor :password
  attr_protected :password

  # #####################################################
  #
  # #####################################################
  def self.hashed(str)
    SHA1.new(str).to_s
  end

  # #####################################################
  # If a user matching the credentials is found, returns the User object.
  # If no matching user is found, returns nil.
  # #####################################################
  def self.authenticate(user_info)
    user = find_by_name(user_info[:name])
    if user && user.hashed_password == hashed(user_info[:password])
      return user
    end
  end

  # #####################################################
  # Called by the rails framework before the user is saved
  # in the database.
  # #####################################################
  def validate
    errors.add(:email, "must be valid.") unless email.include?("@")
    if name.include?(" ")
      errors.add(:name, "cannot include spaces.")
    end
  end

  # #####################################################
  # Helper method for logging the user in.
  # #####################################################
  def login!(session)
    session[:user_id] = id
  end

  # #####################################################
  # Helper method for logging the user out.
  # #####################################################
  def self.logout!(session, cookies)
    session[:user_id] = nil
    cookies.delete(:authorisation_token)
  end

  # #####################################################
  # Helper method for clearing the password.
  # #####################################################
  def clear_password!
    self.password = nil
  end

  # #####################################################
  # Remember a user for future login
  # #####################################################
  def remember!(cookies)
    cookie_expiration = 7.days.from_now
    cookies[:remember_me] = { :value => "1",
                              :expires => cookie_expiration }
    self.authorisation_token = unique_identifier 
    self.save!
    cookies[:authorisation_token] = { :value => self.authorisation_token,
                                      :expires => cookie_expiration }
  end

  # #####################################################
  # Forgets a users' login status
  # #####################################################
  def forget!(cookies)
    cookies.delete(:remember_me)
    cookies.delete(:authorisation_token)
  end

  # #####################################################
  # Returns true if the user wants to remember their login status
  # #####################################################
  def remember_me?
    remember_me == "1"
  end

 private
  before_save :update_password

  def update_password
    if not password.blank?
      self.hashed_password = self.class.hashed(password)
    end
  end
end 
