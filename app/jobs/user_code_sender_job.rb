class UserCodeSenderJob < Struct.new(:id, :ip)

  def perform
    @user = User.find(id)
    @activation = Activation.find_by_user_id(id)

    if @user && @activation
      AuditTrail.create_code_sent_entry(@user, :ip.to_s)
      UserMailer.deliver_activation_code(@user, @activation)
    else
      AuditTrail.create_failed_code_sent_entry(id, :ip.to_s)
    end
  end
end

