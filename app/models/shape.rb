class Shape < ActiveRecord::Base
  include Translatable

  validates_presence_of :name, :sections_width, :sections_height, :corners
  validates_numericality_of :sections_width, :sections_height
end
