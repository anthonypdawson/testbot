class BrowsersController < ApplicationController
  layout "testbot"
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @browser_pages, @browsers = paginate :browsers, :per_page => 10, :order_by=>"created_on DESC"
    if request.xml_http_request?
      render :partial => "list", :layout => false, :locals=>{  :browsers => @browsers}
    end
  end

  def show
    @browser = Browser.find(params[:id])
  end

  def new
    @browser = Browser.new
  end

  def create
    @browser = Browser.new(params[:browser])
    @browser.created_on = Time.now
    if @browser.save
      flash[:notice] = 'Browser was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @browser = Browser.find(params[:id])
  end

  def update
    @browser = Browser.find(params[:id])
    if @browser.update_attributes(params[:browser])
      flash[:notice] = 'Browser was successfully updated.'
      redirect_to :action => 'show', :id => @browser
    else
      render :action => 'edit'
    end
  end

  def destroy
    Browser.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

end
