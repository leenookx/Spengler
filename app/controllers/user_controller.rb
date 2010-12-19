class UserController < ApplicationController
  layout 'standard'
  before_filter :login_required, :only => :my_account


  # #####################################################
  # 
  # #####################################################
  def login
    @title = "Spengler - Login"
  end


  # #####################################################
  # 
  # #####################################################
  def process_login
    if request.post? && params[:user]
      @user = User::FindByName(params[:user])
      if @user
        if @user.status == User::STATUS_OK
          if @user.authenticate?(params[:user])
            session[:id] = @user.id # Remember the user's id during this session

            if @user.remember_me?
              @user.remember!(cookies)
            else
              @user.forget!(cookies)
            end

            AuditTrail.create_login_entry(session, request.remote_ip)

            redirect_to session[:return_to] || '/'
          end
        else
          if @user.status == User::STATUS_AWAITING_VALIDATION
          elsif @user.status == User::STATUS_DISABLED
          else
          end
        end
      else
        flash[:error] = 'Invalid login.'
        redirect_to :action => 'login', :name => params[:user][:name]
      end
    else
      redirect_to '/'
    end
  end


  # #####################################################
  # 
  # #####################################################
  def logout
    AuditTrail.create_logout_entry(session, request.remote_ip)
    User.logout!(session, cookies)

    reset_session
    flash[:message] = 'Logged out.'
    redirect_to :action => 'login'
  end


  # #####################################################
  # 
  # #####################################################
  def my_account
    @title = "Spengler - Your account."
  end


  # #####################################################
  # 
  # #####################################################
  def register
    if request.get?
      @title = "Spengler - Register"
    elsif request.post? and params[:user]
      @user = User.new(params[:user])
      @user.password = "password"
      if @user.save
        flash[:message] = "User #{@user.name} has been registered."

        AuditTrail.create_registration_entry(session, request.remote_ip)

        redirect_to session[:return_to] || '/'
      end
    end
  end
end
