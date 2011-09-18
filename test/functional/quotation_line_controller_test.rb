require File.dirname(__FILE__) + '/../test_helper'
require 'quotation_line_controller'

# Re-raise errors caught by the controller.
class QuotationLineController; def rescue_action(e) raise e end; end

class QuotationLineControllerTest < Test::Unit::TestCase
  def setup
    @controller = QuotationLineController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
