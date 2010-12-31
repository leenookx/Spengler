class UserLinksController < ApplicationController
  # GET /user_links
  # GET /user_links.xml
  def index
    @user_links = UserLink.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_links }
    end
  end

  # GET /user_links/1
  # GET /user_links/1.xml
  def show
    @user_link = UserLink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_link }
    end
  end

  # GET /user_links/new
  # GET /user_links/new.xml
  def new
    @user_link = UserLink.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_link }
    end
  end

  # GET /user_links/1/edit
  def edit
    @user_link = UserLink.find(params[:id])
  end

  # POST /user_links
  # POST /user_links.xml
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

  # PUT /user_links/1
  # PUT /user_links/1.xml
  def update
    @user_link = UserLink.find(params[:id])

    respond_to do |format|
      if @user_link.update_attributes(params[:user_link])
        flash[:notice] = 'UserLink was successfully updated.'
        format.html { redirect_to(@user_link) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_links/1
  # DELETE /user_links/1.xml
  def destroy
    @user_link = UserLink.find(params[:id])
    @user_link.destroy

    respond_to do |format|
      format.html { redirect_to(user_links_url) }
      format.xml  { head :ok }
    end
  end
end
