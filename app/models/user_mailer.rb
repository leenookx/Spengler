class UserMailer < ActionMailer::Base

  # #####################################################
  #
  # #####################################################
  def activation_code(user, activation)
    @subject = "Spengler account activation"
    @body = {}
    # Give body access to the user information
    @body["user"] = user
    @body["activation"] = activation
    @recipients = user.email
    @from = EMAIL_CONFIG['email_from']
  end

  # #####################################################
  #
  # #####################################################
  def invite(invite, user)
    @subject = "An Invitation to join Spengler"
    @body = {}
    # Give body access to the user information
    @body["user"] = user
    @body["invite"] = invite
    @recipients = invite.email
    @from = EMAIL_CONFIG['email_from']
  end
end
