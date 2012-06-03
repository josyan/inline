class CreateDoorPanelDimensions < ActiveRecord::Migration
  def self.up
    create_table :door_panel_dimensions do |t|
      t.integer :door_panel_id
      t.float :width
      t.float :height
      t.float :price

      t.timestamps
    end
  end

  def self.down
    drop_table :door_panel_dimensions
  end
end
