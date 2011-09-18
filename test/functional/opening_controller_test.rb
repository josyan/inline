require File.dirname(__FILE__) + '/../test_helper'
require 'opening_controller'

# Re-raise errors caught by the controller.
class OpeningController; def rescue_action(e) raise e end; end

class OpeningControllerTest < Test::Unit::TestCase
  def setup
    @controller = OpeningController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
