class DoorPanel < ActiveRecord::Base
  has_and_belongs_to_many :door_glasses
end
