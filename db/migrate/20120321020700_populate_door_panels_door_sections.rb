class PopulateDoorPanelsDoorSections < ActiveRecord::Migration
  def self.up
    DoorPanel.all.each do |dp|
      execute "INSERT INTO door_panels_door_sections (door_panel_id, door_section_id) VALUES (#{dp.id}, 3)"
    end
  end

  def self.down
    execute "TRUNCATE TABLE door_panels_door_sections"
  end
end
