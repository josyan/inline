class Option < ActiveRecord::Base
  include Translatable

  belongs_to :pricing_method
  belongs_to :options_minimum_unit
  has_and_belongs_to_many :series, :class_name => 'Serie' # :class_name should not be here, but 'series'.singularize = 'series' for rails, which is not correct
  has_many :options_quotation_lines
  has_many :options_quotations

  has_and_belongs_to_many :option_categories, :order => "option_categories.display_order asc"

  has_attached_file :photo,  
          :url => "/system/:class/:attachment/:id/:style_:basename.:extension",
          :path => ":rails_root/public/system/:class/:attachment/:id/:style_:basename.:extension",
          :default_url => "/images/:class/missing_:style.png",
          :default_style => :original,     :whiny_thumbnails => true,
          :styles => {
             :thumb => "32x32#",
             :normal  => "200x200>",
	           :original => "300x300"
	           }

  validates_attachment_size :photo, :less_than => 1.megabyte


  validates_presence_of :description, :pricing_method_id, :price
  validates_numericality_of :price
  
  
  # find all options that are assigned to a category
#   o = Option.all(:include => :option_categories, :conditions =>['not ISNULL(option_categories_options.option_category_id)'])
  # find all options that are NOT assigned to a category
#   o = Option.all(:include => :option_categories, :conditions =>['ISNULL(option_categories_options.option_category_id)'])


  
  # returns true if this option has been assigned to any categories
  def categorized?
    !option_categories.empty?
  end
  
end
