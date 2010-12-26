class UserInviteJob < Struct.new(:id, :ip)

  def perform
    invite = Invite.find( id )
    user = User.find( invite.user_id )

    if invite && user
      AuditTrail.create_invite_sent_entry(invite, :ip.to_s)
      UserMailer.deliver_invite(invite, user)
    else
      AuditTrail.create_failed_invite_sent_entry(id, :ip.to_s)
    end
  end
end

