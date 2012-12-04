class TestSuitesController < ApplicationController
  layout "testbot", :except => [:select, :test_case_selection]
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
      conditions = "is_active = true"
    else
      conditions = "is_active = true AND project_id = #{@filter}"
    end
    @test_suite_pages, @test_suites = paginate :test_suites, :per_page => 10, :order_by=>"created_on DESC", :conditions=>conditions
    if request.xml_http_request?
      render :partial => "list", :layout => false, :locals=>{  :test_suites => @test_suites}
    end
  end

  def show
    @test_suite = TestSuite.find(params[:id])
  end

  def new
    @test_suite = TestSuite.new
    @projects = Project.find(:all)
  end

  def create
    @test_suite = TestSuite.new(params[:test_suite])
    if @test_suite.save
      flash[:notice] = 'TestSuite was successfully created.'
      redirect_to :action => 'edit', :id=>@test_suite.id
    else
      render :action => 'new'
    end
  end

  def edit
    @test_suite = TestSuite.find(params[:id], :include=>'test_cases')
    @new_test_cases = []
    @new_test_cases += @test_suite.test_cases
  end

  def update
    @test_suite = TestSuite.find(params[:id])
    if @test_suite.update_attributes(params[:test_suite])
      flash[:notice] = 'TestSuite was successfully updated.'
      redirect_to :action => 'edit', :id => @test_suite
    else
      render :action => 'edit'
    end
  end

  def destroy
    TestSuite.find(params[:id]).archive
    redirect_to :action => 'list'
  end

  def select_one
    project_id = params[:project_id]
    render :partial => "select_one", :layout=>false, :locals=>{:project_id => project_id}
  end

  def select
    if params[:project_id] == "" or params[:project_id].nil?
      @test_suites = []
    else
      @test_suites = TestSuite.find(:all, :conditions => "project_id = #{params[:project_id]} and is_active = true").select{|ts| ts if !ts.test_cases.nil? and ts.test_cases.length > 0 }
    end
  end


  def test_cases
  end

  def add_test_cases
    @ts = TestSuite.find(params[:test_suite_id])
    @ts.test_cases = []
    params[:current_test_case_list].each do |tcid|
      @tc = TestCase.find(tcid.to_i)
      @ts.test_cases << TestCase.find(tcid.to_i)
    end
    @ts.update

  end

  def test_case_selection
    @test_suite = TestSuite.find(params[:id])
    @test_cases = TestCase.find(:all, :conditions=>"project_id = #{@test_suite.project.id}")
  end

  def move_test_cases
    params[:current_test_case_list].each_index do |i|
      @test_suite.test_cases << TestCase.find(params[:current_test_case_list][i])
    end
  end

end
