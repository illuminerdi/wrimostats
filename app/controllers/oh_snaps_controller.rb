class OhSnapsController < ApplicationController
  # GET /oh_snaps
  # GET /oh_snaps.xml
  def index
    @oh_snaps = OhSnap.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @oh_snaps }
    end
  end

  # GET /oh_snaps/1
  # GET /oh_snaps/1.xml
  def show
    @oh_snap = OhSnap.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @oh_snap }
    end
  end

  # GET /oh_snaps/new
  # GET /oh_snaps/new.xml
  def new
    @oh_snap = OhSnap.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @oh_snap }
    end
  end

  # GET /oh_snaps/1/edit
  def edit
    @oh_snap = OhSnap.find(params[:id])
  end

  # POST /oh_snaps
  # POST /oh_snaps.xml
  def create
    @oh_snap = OhSnap.new(params[:oh_snap])

    respond_to do |format|
      if @oh_snap.save
        flash[:notice] = 'OhSnap was successfully created.'
        format.html { redirect_to(@oh_snap) }
        format.xml  { render :xml => @oh_snap, :status => :created, :location => @oh_snap }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @oh_snap.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /oh_snaps/1
  # PUT /oh_snaps/1.xml
  def update
    @oh_snap = OhSnap.find(params[:id])

    respond_to do |format|
      if @oh_snap.update_attributes(params[:oh_snap])
        flash[:notice] = 'OhSnap was successfully updated.'
        format.html { redirect_to(@oh_snap) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @oh_snap.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /oh_snaps/1
  # DELETE /oh_snaps/1.xml
  def destroy
    @oh_snap = OhSnap.find(params[:id])
    @oh_snap.destroy

    respond_to do |format|
      format.html { redirect_to(oh_snaps_url) }
      format.xml  { head :ok }
    end
  end
end
