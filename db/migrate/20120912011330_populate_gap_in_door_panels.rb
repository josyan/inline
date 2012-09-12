class PopulateGapInDoorPanels < ActiveRecord::Migration
  def self.up
    DoorPanel.update_all :gap => 'slab'
  end

  def self.down
  end
end
