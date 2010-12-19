# ####################################################################################
# Methods added to this helper will be available to all templates in the application.
# ####################################################################################
module ApplicationHelper
  #require 'string'

  # #####################################################
  # Determines if the user is currently logged in or not
  # #####################################################
  def logged_in?
    not session[:id].nil?
  end

  # #####################################################
  #
  # #####################################################
  def nav_link(text, controller, action="index")
    return link_to_unless_current text, {:controller => controller,
                                        :action => action},
                                        {:class => "small-navigation"}
  end

  # #####################################################
  #
  # #####################################################
  def text_field_for(form, field,
                     size=HTML_TEXT_FIELD_SIZE,
                     maxlength=DB_STRING_MAX_LENGTH)
    label = content_tag("label", "#{field.humanize}:", :for => field)
    form_field = form.text_field field, :size => size, :maxlength => maxlength
    content_tag("div", "#{label} #{form_field}", :class => "form_row")
  end

  # #####################################################
  #
  # #####################################################
  def is_admin_user?
    u = User.find_by_id( session[:user_id] ) if logged_in?

    return u.admin
  end

  def site_mode
    status = SystemStatus.first
    return status.status
  end

  def generate_unique_code
    code = Digest::SHA1.hexdigest([Time.now, rand].join)
    puts code
    return code
  end
end
