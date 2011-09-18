require File.dirname(__FILE__) + '/../test_helper'
require 'option_category_controller'

# Re-raise errors caught by the controller.
class OptionCategoryController; def rescue_action(e) raise e end; end

class OptionCategoryControllerTest < Test::Unit::TestCase
  fixtures :option_categories

  def setup
    @controller = OptionCategoryController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @first_id = option_categories(:first).id
  end


  def test_delete
    get :delete
    assert_response :success
    assert_template 'delete'
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

    assert_not_nil assigns(:option_categories)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:option_category)
    assert assigns(:option_category).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:option_category)
  end

  def test_create
    num_option_categories = OptionCategory.count

    post :create, :option_category => {:name=>"a", :display_order => 1}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_option_categories + 1, OptionCategory.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:option_category)
    assert assigns(:option_category).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      OptionCategory.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      OptionCategory.find(@first_id)
    }
  end
end
