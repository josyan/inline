class CreateDoorPanelsDoorSections < ActiveRecord::Migration
  def self.up
    create_table :door_panels_door_sections, :id => false do |t|
      t.integer :door_panel_id
      t.integer :door_section_id
    end
  end

  def self.down
    drop_table :door_panels_door_sections
  end
end
