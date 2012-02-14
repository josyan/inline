class DoorLine < ActiveRecord::Base
  belongs_to :quotation
  belongs_to :door_frame
  belongs_to :door_combination
  belongs_to :frame_profile
  belongs_to :slab_material
  has_many :door_line_sections, :order => 'order'
  belongs_to :door_opening
  belongs_to :door_boring
  has_many :door_line_options
end
