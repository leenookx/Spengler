class UserMailer < ActionMailer::Base

  def activation_code(user, activation)
    @subject = "Spengler account activation"
    @body = {}
    # Give body access to the user information
    @body["user"] = user
    @body["activation"] = activation
    @recipients = user.email
    @from = 'Spengler <spengler@purplemonkeys.co.uk>'
  end
end
