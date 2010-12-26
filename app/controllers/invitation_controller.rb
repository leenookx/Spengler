class InvitationController < ApplicationController
  include ApplicationHelper
  layout 'standard'

  # ##################################################################
  #
  # ##################################################################
  def new
    @invitation = Invitation.new
  end

  # #####################################################
  # 
  # #####################################################
  def activate
    if request.get?
      @invite = Invite.find_by_code(params[:id])
      if @invite
        @title = "Spengler - Activate Your Invitation"
      else
        flash[:message] = "Invalid invitation code."
        redirect_to root_url
      end
    elsif request.post? and params[:user]
      invite = Invite.find_by_code(params[:id])
      if invite
        if params[:user][:password] == params[:user][:password_confirm]
          @user = User.find(activation.user_id)
          if @user
            @user.update_attributes( params[:user] )
            @user.password = params[:user][:password]
            @user.status = User::STATUS_OK
            
            if @user.save
              flash[:message] = "Thank you. Your user is now active."

              # We can also remove the activation.
              activation.destroy

              redirect_to :action => 'my_account'
            else
              flash[:error] = "Unable to save the user."
            end
          else
            flash[:error] = "Invalid user."
            redirect_to root_url
          end
        else
          flash[:error] = "Passwords don't match."
        end
      else
        flash[:error] = "Invalid activation code."
        redirect_to root_url
      end
    end
  end
end
