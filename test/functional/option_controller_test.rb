require File.dirname(__FILE__) + '/../test_helper'
require 'option_controller'

# Re-raise errors caught by the controller.
class OptionController; def rescue_action(e) raise e end; end

class OptionControllerTest < Test::Unit::TestCase
  def setup
    @controller = OptionController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
