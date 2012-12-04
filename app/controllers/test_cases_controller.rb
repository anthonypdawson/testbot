class TestCasesController < ApplicationController
  layout "testbot", :except=>[:select]
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @filter = params[:filter] if !params[:filter].nil?
    @conditions = "project_id = #{params[:filter]}" if !params[:filter].nil?
    @test_case_pages, @test_cases = paginate :test_cases, :per_page => 10, :order_by=> "created_on DESC", :conditions => @conditions
    if request.xml_http_request?
      render :partial => "list", :layout => false, :locals=>{ :test_cases => @test_cases}
    end
  end

  def show
    @test_case = TestCase.find(params[:id])
  end

  def new
    @test_case = TestCase.new
    @snippets = get_snippets_hash
    @test_suites = []
  end

  def create
    @test_case = TestCase.new(params[:test_case])
    @test_case.created_on = Time.now
    if @test_case.save
      if !params[:test_suite][:id].nil? and params[:test_suite][:id].length > 0
        ts = TestSuite.find(params[:test_suite][:id])
        ts.test_cases << @test_case
        ts.save
      end
      flash[:notice] = 'TestCase was successfully created.'
      redirect_to :action => 'list'
    else
      @test_suites = []
      render :action => 'new'
    end
  end

  def edit
    @test_case = TestCase.find(params[:id])
    @snippets = get_snippets_hash
    @test_suites = @test_case.project.test_suites
  end

  def update
    @test_case = TestCase.find(params[:id])
    if @test_case.update_attributes(params[:test_case])
      if @test_case.save
        if !params[:test_suite][:id].nil? and params[:test_suite][:id].length > 0
          ts = TestSuite.find(params[:test_suite][:id])
          ts.test_cases << @test_case
          ts.save
        end
      end
      flash[:notice] = 'TestCase was successfully updated.'
      redirect_to :action => 'show', :id => @test_case
    else
      @test_suites = @test_case.project.test_suites
      render :action => 'edit'
    end
  end

  def destroy
    TestCase.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def select
    if !params[:id].nil?
      @test_cases = TestCase.find(:all, :conditions=>"project_id = #{params[:id]}")
    else
      @test_cases = TestCase.find(:all)
    end
  end

  private

  def get_snippets_hash
    snippets = { }
    Snippet.find(:all, :conditions=>"project_id is not null and is_active = true").each do |snippet|
      snippets[snippet.project.name] = [] if snippets[snippet.project.name].nil?
      snippets[snippet.project.name] << snippet
    end
    snippets["Unassigned"] = Snippet.find(:all, :conditions=>"project_id is null and is_active = true")
    return snippets
  end
end
