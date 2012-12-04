require File.dirname(__FILE__) + '/../test_helper'
require 'results_controller'

# Re-raise errors caught by the controller.
class ResultsController; def rescue_action(e) raise e end; end

class ResultsControllerTest < Test::Unit::TestCase
  fixtures :results

  def setup
    @controller = ResultsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = results(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:results)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:result)
    assert assigns(:result).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:result)
  end

  def test_create
    num_results = Result.count

    post :create, :result => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_results + 1, Result.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:result)
    assert assigns(:result).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Result.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Result.find(@first_id)
    }
  end
end
