class InvitationController < ApplicationController
  include ApplicationHelper
  layout 'standard'

  # ##################################################################
  #
  # ##################################################################
  def new
    @invitation = Invitation.new
  end
end
