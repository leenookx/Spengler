class UserLinksController < ApplicationController
  include ApplicationHelper

  # ##################################################### 
  # GET /user_links
  # GET /user_links.xml
  # ##################################################### 
  def index
    user = valid_user( request.headers["authentication-token"] || params[:auth_code] )
    if !user.nil?
      # Get the latest links added by the logged in (or specified) user.
      @user_links = UserLink.find_all_by_user_id(user.id, :limit => 20, :order => "updated_at desc")

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @user_links }
        format.json  { render :json => @user_links }
      end
    else
      respond_to do |format|
        format.html do
          flash[:error] = 'Not authenticated.'
          redirect_to root_url
        end

        format.xml { render :xml => { :status => :error, :message => 'Invalid authentication code.'}.to_xml, :status => 403 }

        format.json { render :json => { :status => :error, :message => 'Invalid authentication code.'}.to_json, :status => 403 }
      end
    end
  end

  # ##################################################### 
  # GET /user_links/1
  # GET /user_links/1.xml
  # ##################################################### 
  def show
    @user_link = UserLink.find(params[:id])

    if @user_link
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @user_link }
      end
    else
      flash[:notice] = 'UserLink was successfully created.'
        redirect_to root_url
    end
  end

  # ##################################################### 
  # GET /user_links/new
  # GET /user_links/new.xml
  # ##################################################### 
  def new
    @user_link = UserLink.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_link }
    end
  end

  # ##################################################### 
  # GET /user_links/1/edit
  # ##################################################### 
  def edit
    @user_link = UserLink.find(params[:id])
  end

  # ##################################################### 
  # POST /user_links
  # POST /user_links.xml
  # ##################################################### 
  def create
    @user_link = UserLink.new(params[:user_link])

    respond_to do |format|
      if @user_link.save
        flash[:notice] = 'UserLink was successfully created.'
        format.html { redirect_to(@user_link) }
        format.xml  { render :xml => @user_link, :status => :created, :location => @user_link }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # ##################################################### 
  # PUT /user_links/1
  # PUT /user_links/1.xml
  # ##################################################### 
  def update
#    @user_link = UserLink.find(params[:id])
#
#    respond_to do |format|
#      if @user_link.update_attributes(params[:user_link])
#        flash[:notice] = 'UserLink was successfully updated.'
#        format.html { redirect_to(@user_link) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @user_link.errors, :status => :unprocessable_entity }
#      end
#    end
  end

  # ##################################################### 
  # DELETE /user_links/1
  # DELETE /user_links/1.xml
  # ##################################################### 
  def destroy
#    @user_link = UserLink.find(params[:id])
#    @user_link.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(user_links_url) }
#      format.xml  { head :ok }
#    end
  end
end
