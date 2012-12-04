require File.dirname(__FILE__) + '/../test_helper'
require 'test_suites_controller'

# Re-raise errors caught by the controller.
class TestSuitesController; def rescue_action(e) raise e end; end

class TestSuitesControllerTest < Test::Unit::TestCase
  fixtures :test_suites

  def setup
    @controller = TestSuitesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = test_suites(:first).id
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

    assert_not_nil assigns(:test_suites)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:test_suite)
    assert assigns(:test_suite).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:test_suite)
  end

  def test_create
    num_test_suites = TestSuite.count

    post :create, :test_suite => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_test_suites + 1, TestSuite.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:test_suite)
    assert assigns(:test_suite).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      TestSuite.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      TestSuite.find(@first_id)
    }
  end
end
