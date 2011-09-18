class Serie < ActiveRecord::Base
  include Translatable

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :widths, :order => "value"
  has_many :heights, :order => "value"
  has_many :quotation_lines, :dependent => :destroy
  has_and_belongs_to_many :options, :order => 'description', :include => [:option_categories]
  has_and_belongs_to_many :openings

  def standard_product?
    series_type == "StandardProduct" 
  end
  
  def priced_by_area?
    series_type == "PerSqFtProduct"
  end


  def self.categorize_options(options)
    # take the list of options, and rearrange it to be organized by category.
    # we need to order this list by display order too
    # hash is keyed on category display order. Value is {cat, option[]}
    categorized_options = {}
    options.each { |opt| 
       opt.option_categories.each { |cat|
         categorized_options[cat.display_order] ||= {cat, []}
         categorized_options[cat.display_order][cat] << opt
         }
    }
#    categorized_options.keys.each { |i|
#      categorized_options[i].each { |cat, options|
#      if (!cat.multiselect)
#        none_option = Option.new(:id => -1, :description => "None", :pricing_method => nil, :price => 0, :minimum_quantity => 0)
#        cat << none_option
#      end
#      }
#    }
    categorized_options
  end  

  # return max width available
  def maximum_width
    max_height = self.widths.max_by {|x| x.value}
  end

  # return max height available
  def maximum_height
    max_height = self.heights.max_by {|x| x.value}
  end

end
