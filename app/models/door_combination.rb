class DoorCombination < ActiveRecord::Base
  include Translatable
  include Priceable

  validates_presence_of :name, :sections, :preview_image_name, :door_frame_id

  belongs_to :door_frame
  has_and_belongs_to_many :door_openings
end
