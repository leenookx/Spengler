require 'sha1'

class User < ActiveRecord::Base
  has_one :activation, :dependent => :destroy

  NAME_MIN_LENGTH = 4
  NAME_MAX_LENGTH = 20
  EMAIL_MIN_LENGTH = 10
  EMAIL_MAX_LENGTH = 50
  PASSWORD_MIN_LENGTH = 4
  PASSWORD_MAX_LENGTH = 40

  FORENAME_MIN_LENGTH = 2
  FORENAME_MAX_LENGTH = 20
  SURNAME_MIN_LENGTH = 4
  SURNAME_MAX_LENGTH = 20

  NAME_RANGE = NAME_MIN_LENGTH..NAME_MAX_LENGTH
  EMAIL_RANGE = EMAIL_MIN_LENGTH..EMAIL_MAX_LENGTH
  PASSWORD_RANGE = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH
  FORENAME_RANGE = FORENAME_MIN_LENGTH..FORENAME_MAX_LENGTH
  SURNAME_RANGE = SURNAME_MIN_LENGTH..SURNAME_MAX_LENGTH

  NAME_SIZE = 20
  PASSWORD_SIZE = 20
  EMAIL_SIZE = 30
  FORENAME_SIZE = 20
  SURNAME_SIZE = 20

  STATUS_AWAITING_VALIDATION = 0
  STATUS_OK = 1
  STATUS_DISABLED = 2

  validates_uniqueness_of :name 
  validates_confirmation_of :password, :on => :create, :if =>lambda { |user| user.new_record? or not user.password.blank? }
  validates_length_of :name, :within => NAME_RANGE
  validates_length_of :email, :within => EMAIL_RANGE
  validates_length_of :password, :within => PASSWORD_RANGE, :if =>lambda { |user| user.new_record? or not user.password.blank? }
  validates_length_of :forename, :within => FORENAME_RANGE
  validates_length_of :surname, :within => SURNAME_RANGE

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

  attr_accessor :password_confirm

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
  def authenticate?(user_info)
    if status == User::STATUS_OK 
      if hashed_password == User::hashed(user_info[:password])
        return true
      end
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

  # ##################################################################
  #
  # ##################################################################
  def self.FindByName(user_info)
    user = find_by_name(user_info[:name])
  end

  # ##################################################################
  #
  # ##################################################################
  def avatar
    Avatar.new(self)
  end

  # ##################################################################
  # Invite someone to join this site
  # ##################################################################
  def invite?(email_address, ip)
    invitation = Invitation.new
    invitation.email = email_address
    if (self.invitation_limit > 0) && invitation
      invitation.user_id = self.id
      if invitation.save
        self.invitation_limit -= 1
        self.save

        # Send out the invite at this point...
        Delayed::Job.enqueue( UserInviteJob.new(self.id, ip) )

        # Create a friendship link between the two users.
        friend = Friend.new
        friend.from = invitation.user_id
        friend.to = self.id
        friend.save

        return true
      else
        return false
      end
    else
      return false
    end
  end

 private

  before_save :update_password
  before_save :check_invites

  # ##################################################################
  #
  # ##################################################################
  def update_password
    if not password.blank?
      self.hashed_password = self.class.hashed(password)
    end
  end

  # ##################################################################
  #
  # ##################################################################
  def check_invites
    if invitation_limit.blank?
      self.invitation_limit = 5
    end
  end
end 
