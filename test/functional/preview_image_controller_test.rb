require File.dirname(__FILE__) + '/../test_helper'
require 'preview_image_controller'

# Re-raise errors caught by the controller.
class PreviewImageController; def rescue_action(e) raise e end; end

class PreviewImageControllerTest < Test::Unit::TestCase
  def setup
    @controller = PreviewImageController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
