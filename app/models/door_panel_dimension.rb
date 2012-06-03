class DoorPanelDimension < ActiveRecord::Base
  include Priceable

  belongs_to :door_panel
end
