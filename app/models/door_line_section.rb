class DoorLineSection < ActiveRecord::Base
  belongs_to :door_line
  belongs_to :door_section
  belongs_to :door_panel
  belongs_to :door_glass
  belongs_to :door_section_dimension

  def price
    p = 0

    p
  end

end
