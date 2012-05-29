class AddDoorPanelFamilyIdToDoorPanels < ActiveRecord::Migration
  def self.up
    add_column :door_panels, :door_panel_family_id, :integer
  end

  def self.down
    remove_column :door_panels, :door_panel_family_id
  end
end
