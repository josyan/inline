class DoorLine < ActiveRecord::Base
  belongs_to :quotation
  belongs_to :door_frame
  belongs_to :door_combination
  belongs_to :frame_profile
  belongs_to :slab_material
end
