class LinksController < ApplicationController
  layout 'standard'

  # #####################################################
  # Normally this would return all of the records in the
  # system, such as:
  #   GET /links
  #   GET /links.xm
  #   GET /links.json
  # However, this has been disabled in this system. We
  # don't want prying eyes looking into our database!
  # #####################################################
  def index

    respond_to do |format|
      flash[:error] = 'Function not available.'
      format.html { redirect_to root_url }
      format.xml  { render :xml => @links }
      format.json { render :json => { :status => :error, :message => 'This function is not available'}.to_json, :status => 403 }
    end
  end

  # #####################################################
  # GET /links/1
  # GET /links/1.xml
  # #####################################################
  def show
    @link = Link.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @link }
      format.json { render :json => @link }
    end
  end

  # #####################################################
  # Presents an HTML page for adding new links to the
  # system.
  #   GET /links/new
  #   GET /links/new.xml
  #   GET /links/new.json
  # #####################################################
  def new
    if !@user
      flash[:error] = 'That function is not available until you are logged in.'
      respond_to do |format|
        format.html { redirect_to root_url }
      end
    else
      @link = Link.new
      @title = "Add a new link"

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @link }
        format.json { render :json => @link }
      end
    end
  end

  # #####################################################
  # GET /links/1/edit
  # #####################################################  
  def edit
    @link = Link.find(params[:id])
  end

  # #####################################################
  # POST /links
  # POST /links.xml
  # #####################################################
  def create

    user = valid_user( request.headers["authentication-token"] || params[:auth_code] )
    if user.nil?
      respond_to do |format|
        format.html do
          flash[:error] = 'Not authenticated.'
          redirect_to root_url
        end

        format.xml { render :xml => { :status => :error, :message => 'Invalid authentication code.'}.to_xml, :status => 403 }

        format.json { render :json => { :status => :error, :message => 'Invalid authentication code.'}.to_json, :status => 403 }
      end
    else
      link = Link.find_by_url( params[:links][:url] )
      if !link
        link = Link.new(params[:links])

        if !link
          respond_to do |format|
            format.html { render :action => "new" }
            format.xml  { render :xml => link.errors, :status => :unprocessable_entity }
            format.json { render :json => link.errors, :status => :unprocessable_entity }
          end
        end
      end 
        
      respond_to do |format|
        if link.save
          userlink = UserLink.new
          userlink.user_id = user.id
          userlink.link_id = link.id
          userlink.save

          flash[:notice] = 'Link was successfully created.'
          format.html { redirect_to(link) }
          format.xml  { render :xml => link, :status => :created, :location => link }
          format.json { render :json => link, :status => :created, :location => link }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => link.errors, :status => :unprocessable_entity }
          format.json { render :json => link.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # #####################################################
  # PUT /links/1
  # PUT /links/1.xml
  # #####################################################
  def update
    @link = Link.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(params[:link])
        flash[:notice] = 'Link was successfully updated.'
        format.html { redirect_to(@link) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # #####################################################
  # DELETE /links/1
  # DELETE /links/1.xml
  # #####################################################
  def destroy
    @link = Link.find(params[:id])
    @link.destroy

    respond_to do |format|
      format.html { redirect_to(links_url) }
      format.xml  { head :ok }
    end
  end

 private

  # #####################################################
  # 
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
