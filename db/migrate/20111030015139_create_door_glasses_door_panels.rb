class CreateDoorGlassesDoorPanels < ActiveRecord::Migration
  def self.up
    create_table :door_glasses_door_panels, :id => false do |t|
      t.integer :door_glass_id
      t.integer :door_panel_id
    end
  end

  def self.down
    drop_table :door_glasses_door_panels
  end
end
