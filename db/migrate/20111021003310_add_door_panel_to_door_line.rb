class AddDoorPanelToDoorLine < ActiveRecord::Migration
  def self.up
    add_column :door_lines, :door_panel_id, :integer
  end

  def self.down
    remove_column :door_lines, :door_panel_id
  end
end
