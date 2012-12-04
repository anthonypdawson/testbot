class ResultsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @result_pages, @results = paginate :results, :per_page => 10
  end

  def show
    @result = Result.find(params[:id])
  end

  def new
    @result = Result.new
  end

  def create
    @result = Result.new(params[:result])
    if @result.save
      flash[:notice] = 'Result was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @result = Result.find(params[:id])
  end

  def update
    @result = Result.find(params[:id])
    if @result.update_attributes(params[:result])
      flash[:notice] = 'Result was successfully updated.'
      redirect_to :action => 'show', :id => @result
    else
      render :action => 'edit'
    end
  end

  def destroy
    Result.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
