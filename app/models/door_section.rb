class DoorSection < ActiveRecord::Base
  has_and_belongs_to_many :door_panels
  has_many :door_section_dimensions, :order => 'value'
end
