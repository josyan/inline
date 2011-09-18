require File.dirname(__FILE__) + '/../test_helper'
require 'shape_controller'

# Re-raise errors caught by the controller.
class ShapeController; def rescue_action(e) raise e end; end

class ShapeControllerTest < Test::Unit::TestCase
  def setup
    @controller = ShapeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
