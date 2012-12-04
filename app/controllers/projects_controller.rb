class ProjectsController < ApplicationController
  layout "testbot"
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @project_pages, @projects = paginate :projects, :per_page => 10, :order_by=>"created_on DESC"
    if request.xml_http_request?
      render :partial => "list", :layout => false, :locals=>{  :projects => @projects}
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
    @project.created_on = Time.now
  end

  def create
    @project = Project.new(params[:project])
    revision = Revision.new(:version => params[:new_revision], :is_current => true, :created_on => Time.now)
    environment = Environment.new(:name => params[:environment_name], :is_current => true, :created_on => Time.now, :base_url => params[:environment_base_url])
    if @project.save
      @project.revisions << revision
      @project.environments << environment
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        redirect_to :action => 'list'
      else
        @project.destroy
        render :action => 'new'
      end
    else
      render :action => 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:notice] = 'Project was successfully updated.'
      redirect_to :action => 'show', :id => @project
    else
      render :action => 'edit'
    end
  end

  def destroy
    Project.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
