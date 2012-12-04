class EnvironmentsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @environment_pages, @environments = paginate :environments, :per_page => 10
  end

  def show
    @environment = Environment.find(params[:id])
  end

  def new
    @environment = Environment.new
  end

  def create
    @environment = Environment.new(params[:environment])
    if @environment.save
      flash[:notice] = 'Environment was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @environment = Environment.find(params[:id])
  end

  def update
    @environment = Environment.find(params[:id])
    if @environment.update_attributes(params[:environment])
      flash[:notice] = 'Environment was successfully updated.'
      redirect_to :action => 'show', :id => @environment
    else
      render :action => 'edit'
    end
  end

  def destroy
    Environment.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def add
    environment = Environment.find(:first, :conditions=>"project_id = #{params[:project_id]} and name = '#{params[:name]}'")
    if environment.nil?
      @environment = Environment.new(:project_id => params[:project_id], :name => params[:name], :base_url => params[:base_url])
    else
      @environment = environment
    end
    @environment.is_current = true
    @environment.save
    @project = @environment.project
    render :partial=>"projects/add_environment"
  end

  def remove
    @environment = Environment.find(params[:id])
    @project = @environment.project
    @environment.is_current = false
    @environment.update
    render :partial => "projects/add_environment", :layout=>false
  end

end
