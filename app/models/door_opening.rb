class DoorOpening < ActiveRecord::Base
  has_and_belongs_to_many :door_combinations
end
