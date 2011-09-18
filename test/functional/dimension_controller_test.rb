require File.dirname(__FILE__) + '/../test_helper'
require 'dimension_controller'

# Re-raise errors caught by the controller.
class DimensionController; def rescue_action(e) raise e end; end

class DimensionControllerTest < Test::Unit::TestCase
  def setup
    @controller = DimensionController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
