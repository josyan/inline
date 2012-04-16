class CreateDoorPanelFamilies < ActiveRecord::Migration
  def self.up
    create_table :door_panel_families do |t|
      t.string :name
      t.integer :slab_material_id

      t.timestamps
    end
  end

  def self.down
    drop_table :door_panel_families
  end
end
