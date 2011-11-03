class DoorLineSection < ActiveRecord::Base
  belongs_to :door_line
  belongs_to :door_section
  belongs_to :door_panel
  belongs_to :door_glass
end
