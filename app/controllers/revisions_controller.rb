class RevisionsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @revision_pages, @revisions = paginate :revisions, :per_page => 10
  end

  def show
    @revision = Revision.find(params[:id])
  end

  def new
    @revision = Revision.new
  end

  def create
    @revision = Revision.new(params[:revision])
    if @revision.save
      flash[:notice] = 'Revision was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @revision = Revision.find(params[:id])
  end

  def update
    @revision = Revision.find(params[:id])
    if @revision.update_attributes(params[:revision])
      flash[:notice] = 'Revision was successfully updated.'
      redirect_to :action => 'show', :id => @revision
    else
      render :action => 'edit'
    end
  end

  def destroy
    Revision.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def add
    revision = Revision.find(:first, :conditions=>"project_id = #{params[:project_id]} and version = '#{params[:version]}'")
    if revision.nil?
      @revision = Revision.new(:project_id => params[:project_id], :version => params[:version])
    else
      @revision = revision
    end
    @revision.is_current = true
    @revision.save
    @project = @revision.project
    render :partial=>"projects/add_version"
  end

  def remove
    @revision = Revision.find(params[:id])
    @project = @revision.project
    @revision.is_current = false
    @revision.update
    render :partial=>"projects/add_version", :layout=>false
  end
end
