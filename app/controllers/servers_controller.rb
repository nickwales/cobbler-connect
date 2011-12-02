class ServersController < ApplicationController

  def cobbler_connect()
    require 'xmlrpc/client'
    server = XMLRPC::Client.new2("http://spacewalk.eutrips.live/cobbler_api")
    return server
  end

  def cobbler_login()
    token = remote.login("xmluser","xmlpassword")
    return server
  end

  # GET /servers
  # GET /servers.json
  def index
    server = cobbler_connect()
#    server_info = server.call("get_systems")
#    @servers = Server.all

    @servers = server.call("get_systems")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @servers }
    end
  end

  # GET /servers/1
  # GET /servers/1.json
  def show
    @server = Server.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @server }
    end
  end

  # GET /servers/new
  # GET /servers/new.json
  def new
    @server = Server.new
    
    require 'xmlrpc/client'
    profile = XMLRPC::Client.new2("http://spacewalk.eutrips.live/cobbler_api") 
    @profile_info = profile.call("get_profiles") 
    @profile_names = Array.new
    @profile_info.each do |pi|
      @profile_names << pi["name"]
    end
    
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @server }
    end
  end

  # GET /servers/1/edit
  def edit
    @server = Server.find(params[:id])
  end

  # POST /servers
  # POST /servers.json
  def create
    @server = Server.new(params[:server])

    respond_to do |format|
      if @server.save
        format.html { redirect_to @server, :notice => 'Server was successfully created.' }
        format.json { render :json => @server, :status => :created, :location => @server }
      else
        format.html { render :action => "new" }
        format.json { render :json => @server.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /servers/1
  # PUT /servers/1.json
  def update
    @server = Server.find(params[:id])

    respond_to do |format|
      if @server.update_attributes(params[:server])
        format.html { redirect_to @server, :notice => 'Server was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @server.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /servers/1
  # DELETE /servers/1.json
  def destroy
    @server = Server.find(params[:id])
    @server.destroy

    respond_to do |format|
      format.html { redirect_to servers_url }
      format.json { head :ok }
    end
  end
  
  
  
end
