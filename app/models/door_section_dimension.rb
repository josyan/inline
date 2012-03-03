class DoorSectionDimension < ActiveRecord::Base
  include Priceable

  belongs_to :door_section
end
