class DoorFrame < ActiveRecord::Base
  include Translatable
  include Priceable

  validates_presence_of :name, :sections, :preview_image_name

  has_many :door_combinations
end
