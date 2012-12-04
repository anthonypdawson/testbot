require File.dirname(__FILE__) + '/../test_helper'
require 'test_suite_executions_controller'

# Re-raise errors caught by the controller.
class TestSuiteExecutionsController; def rescue_action(e) raise e end; end

class TestSuiteExecutionsControllerTest < Test::Unit::TestCase
  fixtures :test_suite_executions

  def setup
    @controller = TestSuiteExecutionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = test_suite_executions(:first).id
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

    assert_not_nil assigns(:test_suite_executions)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:test_suite_execution)
    assert assigns(:test_suite_execution).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:test_suite_execution)
  end

  def test_create
    num_test_suite_executions = TestSuiteExecution.count

    post :create, :test_suite_execution => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_test_suite_executions + 1, TestSuiteExecution.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:test_suite_execution)
    assert assigns(:test_suite_execution).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      TestSuiteExecution.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      TestSuiteExecution.find(@first_id)
    }
  end
end
