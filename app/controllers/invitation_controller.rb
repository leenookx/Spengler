class InvitationController < ApplicationController
  include ApplicationHelper

  # ##################################################################
  #
  # ##################################################################
  def new
    @invitation = Invitation.new
  end

  # ##################################################################
  #
  # ##################################################################
  def create
    if request.post?
      if logged_in?
        @invitation = Invitation.new(params[:invitation])
        @invitation.user_id = @user.id
        if @invitation.save
          Mailer.deliver_invitation(@invitation, signup_url(@invitation.token))
          flash[:notice] = "Thank you, invitation sent."
          render :update do |page|
            page.replace_html 'invitations-remaining', :partial => 'invitations/invitations_remaining'
            page.visual_effect :highlight, 'invitations-remaining'
          end
        else
          flash[:error] = "Something went wrong. Please panic."
        end
      else
        flash[:error] = "You are not logged in and cannot use that function."
        redirect_to root_url
      end
    else
      redirect_to root_url
    end
  end
end
