require File.dirname(__FILE__) + '/../test_helper'
require 'revisions_controller'

# Re-raise errors caught by the controller.
class RevisionsController; def rescue_action(e) raise e end; end

class RevisionsControllerTest < Test::Unit::TestCase
  fixtures :revisions

  def setup
    @controller = RevisionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = revisions(:first).id
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

    assert_not_nil assigns(:revisions)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:revision)
    assert assigns(:revision).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:revision)
  end

  def test_create
    num_revisions = Revision.count

    post :create, :revision => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_revisions + 1, Revision.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:revision)
    assert assigns(:revision).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Revision.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Revision.find(@first_id)
    }
  end
end
