class PopulateSideDoorPanels < ActiveRecord::Migration
  def self.up
    DoorPanelFamily.all.each do |door_panel_family|
      [50, 51, 53, 55, 56, 60, 61].each do |i|
        DoorPanel.create :name => "Panneau #{i}", :preview_image_name => "panel_#{'%02d' % i}.png", :door_panel_family_id => door_panel_family.id
      end
    end
  end

  def self.down
    DoorPanel.delete_all :conditions => 'id >= 49'
  end
end
