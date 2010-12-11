class AuditTrail < ActiveRecord::Base

  def self.create_login_entry(session, ip)
    a = AuditTrail.new
    a.user_id = session[:user_id]
    # Ok, so only save the record if there is a user id, otherwise the
    # database will chuck a wobbly.
    if a.user_id
      a.log_entry = "Logged in from " + ip + "."
      a.save
    end
  end

  def self.create_logout_entry(session, ip)
    a = AuditTrail.new
    a.user_id = session[:user_id]
    # Ok, so only save the record if there is a user id, otherwise the
    # database will chuck a wobbly.
    # Best I can tell, we only really get here when the users' session
    # has expired.
    if a.user_id
      a.log_entry = "Logged out from " + ip + "."
      a.save
    end
  end

  def self.create_reminder_entry(user, ip)
    a = AuditTrail.new
    a.user_id = user.id
    a.log_entry = "Requested a password reminder from " + ip + "."
    a.save
  end

  def self.create_failed_reminder_entry(entry, ip_address)
    a = AuditTrail.new
    a.user_id = 0
    a.log_entry = "Failed reminder for '" + entry + "' from " + ip_address + "."
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

  def self.create_tag_ingested(user)
    a = AuditTrail.new
    a.user_id = user.id
    a.log_entry = "New tag ingested."
    a.save
  end    
end
