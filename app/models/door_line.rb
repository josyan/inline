class DoorLine < ActiveRecord::Base
  belongs_to :quotation
  belongs_to :door_frame
end
