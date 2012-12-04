require File.dirname(__FILE__) + '/../test_helper'
require 'frontpage_controller'

# Re-raise errors caught by the controller.
class FrontpageController; def rescue_action(e) raise e end; end

class FrontpageControllerTest < Test::Unit::TestCase
  def setup
    @controller = FrontpageController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
