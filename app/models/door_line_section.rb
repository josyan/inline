class DoorLineSection < ActiveRecord::Base
  belongs_to :door_line
  belongs_to :door_section
  belongs_to :door_panel
  belongs_to :door_glass
  belongs_to :door_panel_dimension

  def price
    p = 0

    # door section
    p += door_section.price

    # door panel
    p += door_panel.price if door_panel

    # door glass
    p += door_glass.price if door_glass

    # section dimension
    p += door_panel_dimension.price

    p
  end

end
