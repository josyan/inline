class Opening < ActiveRecord::Base
  include Translatable

  has_many :serie_prices, :dependent => :destroy
  has_many :quotation_lines_openings, :dependent => :destroy
  has_many :preview_images, :dependent => :destroy
  has_and_belongs_to_many :series, :class_name => 'Serie'

  validates_presence_of :name, :abbreviation, :glasses_quantity
end
