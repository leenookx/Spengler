class LinksController < ApplicationController

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
  # GET /links/new
  # GET /links/new.xml
  # #####################################################
  def new
    @link = Link.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @link }
      format.json { render :json => @link }
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
    if !params[:auth]
      flash[:error] = 'Not authenticated.'
      respond_to do |format|
        format.html { redirect_to root_url }
        format.xml  { head :error }
        format.json { render :json => { :status => :error, :message => 'Could not be added'}.to_json, :status => 400 }
      end
    else
      @user = User.find_by_authentication_code(params[:auth])
      if @user
        @link = Link.new(params[:link])

        respond_to do |format|
          if @link.save
            flash[:notice] = 'Link was successfully created.'
            format.html { redirect_to(@link) }
            format.xml  { render :xml => @link, :status => :created, :location => @link }
            format.json { render :json => @link, :status => :created, :location => @link }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
            format.json { render :json => @link.errors, :status => :unprocessable_entity }
          end
        end
      else
        flash[:error] = 'Invalid authentication code.'
        respond_to do |format|
          format.html { redirect_to root_url }
          format.xml  { head :error }
          format.json { render :json => { :status => :error, :message => 'Invalid authentication code.'}.to_json, :status => 403 }
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
end
