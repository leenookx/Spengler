class Invitation < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'
  has_one :recipient, :class_name => 'User'

  EMAIL_MIN_LENGTH = 10
  EMAIL_MAX_LENGTH = 50

  EMAIL_RANGE = EMAIL_MIN_LENGTH..EMAIL_MAX_LENGTH

  EMAIL_SIZE = 20

  validate :recipient_is_not_registered
  validate :sender_has_invitations, :if => :sender

  validates_format_of     :email,
                          :with => /^[A-Z0-9._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i,
                          :message => "must be a valid email address."

  before_save :generate_token

 private

  # ##################################################################
  #
  # ##################################################################
  def recipient_is_not_registered
    errors.add :email, 'is already registered' if User.find_by_email(self.email) || Invitation.find_by_email( self.email )
  end

  # ##################################################################
  #
  # ##################################################################
  def sender_has_invitations
    unless sender.invitation_limit > 0
      errors.add_to_base 'You have reached your limit of invitations to send.'
    end
  end

  # ##################################################################
  #
  # ##################################################################
  def generate_token
    self.code = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end
