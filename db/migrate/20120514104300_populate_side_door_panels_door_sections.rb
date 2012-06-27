class PopulateSideDoorPanelsDoorSections < ActiveRecord::Migration
  def self.up
    DoorPanel.all(:conditions => 'id >= 49').each do |dp|
      execute "INSERT INTO door_panels_door_sections (door_panel_id, door_section_id) VALUES (#{dp.id}, 1)"
      execute "INSERT INTO door_panels_door_sections (door_panel_id, door_section_id) VALUES (#{dp.id}, 2)"
      execute "INSERT INTO door_panels_door_sections (door_panel_id, door_section_id) VALUES (#{dp.id}, 4)"
      execute "INSERT INTO door_panels_door_sections (door_panel_id, door_section_id) VALUES (#{dp.id}, 5)"
    end
  end

  def self.down
    execute "TRUNCATE TABLE door_panels_door_sections WHERE door_panel_id >= 49"
  end
end
