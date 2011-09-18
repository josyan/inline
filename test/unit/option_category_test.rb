require File.dirname(__FILE__) + '/../test_helper'

class OptionCategoryTest < Test::Unit::TestCase
  fixtures :option_categories

  # Replace this with your real tests.
  def test_should_find_all_option_categories
    @ocats = OptionCategory.all()
    assert_not_nil(@ocats)
    assert(@ocats.length == 3)
  end

  def test_category_name_present
    cat = OptionCategory.new;
    cat.description = "a category with no name"
    cat.display_order = 1
    cat.save
    assert cat.errors.on(:name)
  end

  def test_fixture_name_present
    cat = OptionCategory.find(1)
    assert(cat.name == 'Interior')
  end
  
  def test_display_order_present
    cat = OptionCategory.new;
    cat.name = "no display order"
    cat.description = "a category with no display order"
    cat.save
    assert cat.errors.on(:display_order)
  end
end
