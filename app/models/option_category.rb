class OptionCategory < ActiveRecord::Base
  include Translatable
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :display_order
  validates_numericality_of :display_order
  
  has_and_belongs_to_many :options, :class_name => "Option"
#  has_many :options, :through => "option_categories_options"
#  has_many :options, :class_name => "Option", :foreign_key => "option_id", :through => "option_categories_options"
#  belongs_to :options, :class_name => "Option"

  # returns true 
  def has_options?
    options.exists?
  end
end
