class DoorGlassFamily < ActiveRecord::Base
  has_many :door_glasses, :dependent => :destroy
end
