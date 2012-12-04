class TestSuiteExecutionsController < ApplicationController
  layout 'testbot', :except => [:select_browser_control]

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @filter = params[:filter]
    if @filter.nil?
      conditions = "is_test = false"
    else
      conditions = "is_test = false and project_id = #{@filter}"
    end
    @test_suite_execution_pages, @test_suite_executions = paginate :test_suite_executions, :include=>[:project, :results, :environment, :test_suites, :revision],:per_page => 10, :order_by => "test_suite_executions.created_on DESC", :conditions=>conditions
    if request.xml_http_request?
      render :partial => "list", :layout => false, :locals=>{:test_suite_executions => @test_suite_executions}
    end
  end

  def show
    @test_suite_execution = TestSuiteExecution.find(params[:id])
    @result_pages, @results = paginate_collection @test_suite_execution.results, :per_page => 10
  end

  def new
    @test_suite_execution = TestSuiteExecution.new
    @projects = Project.find(:all)
    @executions = TestSuiteExecution.find(:all)
  end

  def create
    @test_suite_execution = TestSuiteExecution.new(params[:test_suite_execution])
    @test_suite_execution.browsers << Browser.find(params[:test_suite_execution][:browser_ids].first) if !params[:test_suite_execution][:browser_ids].nil?
    @test_suite_execution.browsers.uniq!
    @test_suite_execution.created_on = Time.now
    if @test_suite_execution.save
      flash[:notice] = 'TestSuiteExecution was successfully created.'
      redirect_to :action => 'list'
    else
      @projects = Project.find(:all)
      @executions = TestSuiteExecution.find(:all)
      render :action => 'new'
    end
  end

  def create_test
    @test_suite_execution = TestSuiteExecution.new(params[:test_suite_execution])
    @test_suite_execution.test_cases << TestCase.find(params[:test_case][:id])
    @test_suite_execution.test_suites = []
    @test_suite_execution.browsers << Browser.find(params[:test_suite_execution][:browser_ids].first) if !params[:test_suite_execution][:browser_ids].nil?
    @test_suite_execution.browsers.uniq!
    @test_suite_execution.created_on = Time.now
    if @test_suite_execution.save
      flash[:notice] = 'TestSuiteExecution was successfully created.'
      redirect_to :action => 'view_preview_result', :id=> @test_suite_execution
    else
      @projects = Project.find(:all)
      @executions = TestSuiteExecution.find(:all)
      render :action => 'new'
    end
  end

  def create_preview

  end

  def edit
    @test_suite_execution = TestSuiteExecution.find(params[:id])
  end

  def update
    @test_suite_execution = TestSuiteExecution.find(params[:id])
    if @test_suite_execution.update_attributes(params[:test_suite_execution])
      flash[:notice] = 'TestSuiteExecution was successfully updated.'
      redirect_to :action => 'show', :id => @test_suite_execution
    else
      render :action => 'edit'
    end
  end

  def destroy
    TestSuiteExecution.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def select_browser_control
    if params[:selenium_server_id] == "" or params[:selenium_server_id].nil?
      @browsers = []
    else
      selenium_server = SeleniumServer.find(params[:selenium_server_id])
      @browsers = Browser.find(:all, :include=>"selenium_servers").select{|b| b if b.selenium_servers.include?(selenium_server)}
    end
  end

  def select_revision
    @project = Project.find(params[:project_id])
    @revisions = @project.revisions.select{|revision| revision.current? }
    render :partial=>"select_revision"
  end

  def select_environment
    @project = Project.find(params[:project_id])
    @environments = @project.environments
    render :partial=>"select_environment"
  end

  def check_status
    @test_suite_execution = TestSuiteExecution.find(params[:id])
    if @test_suite_execution.is_test
      render :partial=>"check_status_test", :layout=>false
    else
      render :partial=>"check_status", :layout=>false
    end
  end

  def preview_test_case
    @test_case = TestCase.find(params[:id])
    @project = @test_case.project
    @revisions = @project.revisions
    @environments = @project.environments
    @test_suite_execution = TestSuiteExecution.new
    @test_suite_execution.test_suites = []
    @test_suite_execution.project = @test_case.project
    @test_suite_execution.test_cases << @test_case
  end

  def view_preview_result
    @test_suite_execution = TestSuiteExecution.find(params[:id])
  end

end
