require File.dirname(__FILE__) + '/../test_helper'
require 'selenium_servers_controller'

# Re-raise errors caught by the controller.
class SeleniumServersController; def rescue_action(e) raise e end; end

class SeleniumServersControllerTest < Test::Unit::TestCase
  fixtures :selenium_servers

  def setup
    @controller = SeleniumServersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = selenium_servers(:first).id
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

    assert_not_nil assigns(:selenium_servers)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:selenium_server)
    assert assigns(:selenium_server).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:selenium_server)
  end

  def test_create
    num_selenium_servers = SeleniumServer.count

    post :create, :selenium_server => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_selenium_servers + 1, SeleniumServer.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:selenium_server)
    assert assigns(:selenium_server).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      SeleniumServer.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      SeleniumServer.find(@first_id)
    }
  end
end
