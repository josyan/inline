require File.dirname(__FILE__) + '/../test_helper'
require 'database_translation_controller'

# Re-raise errors caught by the controller.
class DatabaseTranslationController; def rescue_action(e) raise e end; end

class DatabaseTranslationControllerTest < Test::Unit::TestCase
  def setup
    @controller = DatabaseTranslationController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
