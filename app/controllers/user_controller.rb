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
    if user = User.authenticate(params[:user])
      session[:id] = user.id # Remember the user's id during this session
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
