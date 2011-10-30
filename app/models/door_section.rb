class DoorSection < ActiveRecord::Base
  has_and_belongs_to_many :door_panels
end
