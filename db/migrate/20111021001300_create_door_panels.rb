class CreateDoorPanels < ActiveRecord::Migration
  def self.up
    create_table :door_panels do |t|
      t.string :name
      t.string :preview_image_name

      t.timestamps
    end
  end

  def self.down
    drop_table :door_panels
  end
end
