class PopulateDoorPanels < ActiveRecord::Migration
  def self.up
    1.upto(24) do |i|
      DoorPanel.create :name => "Panneau #{i}", :preview_image_name => "panel_#{'%02d' % i}.png"
    end
  end

  def self.down
    DoorPanel.delete_all
  end
end
