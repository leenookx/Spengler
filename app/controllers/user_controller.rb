class UserController < ApplicationController
  layout 'standard'
  before_filter :login_required, :only => :my_account


  # #####################################################
  # 
  # #####################################################
  def login
    @title = "Dasher - Login"
  end


  # #####################################################
  # 
  # #####################################################
  def process_login
    if @user = User.authenticate(params[:user])
      session[:id] = @user.id # Remember the user's id during this session

      if @user.remember_me?
        @user.remember!(cookies)
      else
        @user.forget!(cookies)
      end

      AuditTrail.create_login_entry(session, request.remote_ip)

      redirect_to session[:return_to] || '/'
    else
      flash[:error] = 'Invalid login.'
      redirect_to :action => 'login', :name => params[:user][:name]
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
    @title = "Dasher - Your account."
  end


  # #####################################################
  # 
  # #####################################################
  def register
    if request.get?
      @title = "Register"
    elsif request.post? and params[:user]
      @user = User.new(params[:user])
      @user.password = "password"
      if @user.save
        flash[:message] = "User #{@user.name} has been registered."
        redirect_to session[:return_to] || '/'
      end
    end
  end
end
