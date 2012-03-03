class DoorSection < ActiveRecord::Base
  DEFAULT_HEIGHT = 80

  include Priceable

  has_and_belongs_to_many :door_panels
  has_many :door_section_dimensions, :order => 'value'

  def openable?
    ['SL', 'SLO'].include? code
  end

end
