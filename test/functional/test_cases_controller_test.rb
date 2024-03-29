require File.dirname(__FILE__) + '/../test_helper'
require 'test_cases_controller'

# Re-raise errors caught by the controller.
class TestCasesController; def rescue_action(e) raise e end; end

class TestCasesControllerTest < Test::Unit::TestCase
  fixtures :test_cases

  def setup
    @controller = TestCasesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = test_cases(:first).id
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

    assert_not_nil assigns(:test_cases)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:test_case)
    assert assigns(:test_case).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:test_case)
  end

  def test_create
    num_test_cases = TestCase.count

    post :create, :test_case => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_test_cases + 1, TestCase.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:test_case)
    assert assigns(:test_case).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      TestCase.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      TestCase.find(@first_id)
    }
  end
end
