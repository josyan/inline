class DoorOpening < ActiveRecord::Base
  include Priceable

  has_and_belongs_to_many :door_combinations
end
