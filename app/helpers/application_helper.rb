# ####################################################################################
# Methods added to this helper will be available to all templates in the application.
# ####################################################################################
module ApplicationHelper

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
    return link_to_unless_current(text, {:controller => controller,
                                        :action => action},
                                        {:class => "small-navigation"})
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


  # #####################################################
  #
  # #####################################################
  def site_mode
    return APP_CONFIG['mode']
  end


  # #####################################################
  #
  # #####################################################
  def generate_unique_code
    code = Digest::SHA1.hexdigest([Time.now, rand].join)
    return code
  end

  
  # #####################################################
  # Checks to see if the user details passed in are for
  # a valid user or not.
  # #####################################################
  def valid_user(params)
    return @user unless @user.nil?

    if params && !params.empty?
      return User.find_by_authentication_code( params )
    else
      return nil
    end
  end
end
