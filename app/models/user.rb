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
  validates_confirmation_of :password, :on => :create
  validates_length_of :name, :within => NAME_RANGE
  validates_length_of :email, :within => EMAIL_RANGE
  validates_length_of :password, :within => PASSWORD_RANGE

  # #####################################################
  # If a user matching the credentials is found, returns the User object.
  # If no matching user is found, returns nil.
  # #####################################################
  def self.authenticate(user_info)
    find_by_name_and_password(user_info[:name], user_info[:password])
  end
end 
