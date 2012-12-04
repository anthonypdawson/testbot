class SnippetsController < ApplicationController
  layout "testbot"
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
      conditions = "is_active = true and project_id = #{@filter}"
    end
    @snippet_pages, @snippets = paginate :snippets, :per_page => 10, :order_by=>"id DESC", :conditions => conditions
    if request.xml_http_request?
      render :partial => "list", :layout => false, :locals=>{  :snippets => @snippets}
    end
  end

  def show
    @snippet = Snippet.find(params[:id])
  end

  def new
    @snippet = Snippet.new
    @snippets = get_snippets_hash
  end

  def create
    @snippet = Snippet.new(params[:snippet])
    if @snippet.save
      flash[:notice] = 'Snippet was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @snippet = Snippet.find(params[:id])
    @snippets = get_snippets_hash
  end

  def update
    @snippet = Snippet.find(params[:id])
    if @snippet.update_attributes(params[:snippet])
      flash[:notice] = 'Snippet was successfully updated.'
      redirect_to :action => 'show', :id => @snippet
    else
      render :action => 'edit'
    end
  end

  def destroy
    s = Snippet.find(params[:id]).archive
    redirect_to :action => 'list'
  end

  private
  def get_snippets_hash
    snippets = {  }
    Snippet.find(:all, :conditions=>"project_id is not null and is_active = true").each do |snippet|
      snippets[snippet.project.name] = [] if snippets[snippet.project.name].nil?
      snippets[snippet.project.name] << snippet
    end
    snippets["Unassigned"] = Snippet.find(:all, :conditions=>"project_id is null and is_active = true")
    return snippets
  end

end

