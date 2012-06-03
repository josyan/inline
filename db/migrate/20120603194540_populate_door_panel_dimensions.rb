class PopulateDoorPanelDimensions < ActiveRecord::Migration
  def self.up
    price = 1
    DoorPanel.all.each do |door_panel|
      door_panel.door_panel_dimensions.create :width => 30, :height => 84, :price => price
      price += 1
    end
  end

  def self.down
    DoorPanelDimension.clear
  end
end
