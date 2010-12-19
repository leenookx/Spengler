class InterestedPeopleController < ApplicationController
  layout 'standard'

  # #####################################################
  # 
  # #####################################################
  def register
    if request.get?
      @title = "Spengler - Register Your Interest"
    elsif request.post? and params[:interested_people]
      @user = InterestedPeople.new(params[:interested_people])
      if @user.save
        flash[:message] = "Thank you. You have been pre-registered."

        AuditTrail.create_preregistration_entry(request.remote_ip, @user.id)

        redirect_to session[:return_to] || '/'
      end
    end
  end
end
