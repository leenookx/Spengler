class AuditTrail < ActiveRecord::Base

  def self.create_login_entry(session, ip)
    a = AuditTrail.new
    a.user_id = session[:id]
    # Ok, so only save the record if there is a user id, otherwise the
    # database will chuck a wobbly.
    if a.user_id
      a.log_entry = "Logged in from " + ip + "."
      a.save
    end
  end

  def self.create_logout_entry(session, ip)
    a = AuditTrail.new
    a.user_id = session[:id]
    # Ok, so only save the record if there is a user id, otherwise the
    # database will chuck a wobbly.
    # Best I can tell, we only really get here when the users' session
    # has expired.
    if a.user_id
      a.log_entry = "Logged out from " + ip + "."
      a.save
    end
  end

  def self.create_code_sent_entry(user, ip)
    a = AuditTrail.new
    a.user_id = user.id
    a.log_entry = "Sent an activation code " + ip + "."
    a.save
  end

  def self.create_failed_code_sent_entry(entry, ip)
    a = AuditTrail.new
    a.user_id = entry
    a.log_entry = "Failed reminder requested from " + ip + "."
    a.save
  end

  def self.create_avatar_entry(user)
    a = AuditTrail.new
    a.user_id = user.id
    a.log_entry = "Avatar image change requested."
    a.save
  end

  def self.create_failed_avatar_entry(user)
    a = AuditTrail.new
    a.user_id = user.id
    a.log_entry = "Avatar image failed."
    a.save
  end

  def self.create_preregistration_entry(ip_address, id)
    a = AuditTrail.new
    a.user_id = id
    a.log_entry = "New pre-registration from " + ip_address
    a.save
  end

  def self.create_registration_entry(ip_address, id)
    a = AuditTrail.new
    a.user_id = id
    a.log_entry = "New registration from " + ip_address
    a.save
  end

  def self.create_invite_sent_entry(id, ip_address)
    a = AuditTrail.new
    a.user_id = id
    a.log_entry = "Invitation sent thanks to " + ip_address
    a.save
  end

  def self.create_failed_invite_sent_entry(id, ip_address)
    a = AuditTrail.new
    a.user_id = id
    a.log_entry = "Invitation failed. " + ip_address
    a.save
  end
end
