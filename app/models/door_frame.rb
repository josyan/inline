class DoorFrame < ActiveRecord::Base
  validates_presence_of :name, :sections, :preview_image_name
end
