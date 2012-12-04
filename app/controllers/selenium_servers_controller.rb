class SeleniumServersController < ApplicationController
  layout "testbot"
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @selenium_server_pages, @selenium_servers = paginate :selenium_servers, :per_page => 10, :order_by=>"created_on DESC", :conditions => "is_active = true"
    if request.xml_http_request?
      render :partial => "list", :layout => false, :locals=>{  :selenium_servers => @selenium_servers}
    end
  end

  def show
    @selenium_server = SeleniumServer.find(params[:id])
  end

  def new
    @selenium_server = SeleniumServer.new
  end

  def create
    @selenium_server = SeleniumServer.new(params[:selenium_server])
    if @selenium_server.save
      flash[:notice] = 'SeleniumServer was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @selenium_server = SeleniumServer.find(params[:id])
  end

  def update
    @selenium_server = SeleniumServer.find(params[:id])
    if @selenium_server.update_attributes(params[:selenium_server])
      flash[:notice] = 'SeleniumServer was successfully updated.'
      redirect_to :action => 'show', :id => @selenium_server
    else
      render :action => 'edit'
    end
  end

  def destroy
    SeleniumServer.find(params[:id]).archive
    redirect_to :action => 'list'
  end
end
