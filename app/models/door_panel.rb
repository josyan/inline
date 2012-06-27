class DoorPanel < ActiveRecord::Base
  include Priceable

  has_and_belongs_to_many :door_glasses
  has_and_belongs_to_many :door_sections
  belongs_to :door_panel_family
  has_many :door_panel_dimensions, :order => 'height ASC, width ASC'
end
