class DoorCombination < ActiveRecord::Base
  include Translatable

  validates_presence_of :name, :sections, :preview_image_name, :door_frame_id

  belongs_to :door_frame
end
