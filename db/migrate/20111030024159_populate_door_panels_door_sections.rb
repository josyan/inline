class PopulateDoorPanelsDoorSections < ActiveRecord::Migration
  def self.up
    1.upto(24) do |i|
      execute "INSERT INTO door_panels_door_sections (door_panel_id, door_section_id) VALUES (#{i}, 3)"
    end
  end

  def self.down
    execute "TRUNCATE TABLE door_panels_door_sections"
  end
end
