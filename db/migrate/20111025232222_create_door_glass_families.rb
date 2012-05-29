class CreateDoorGlassFamilies < ActiveRecord::Migration
  def self.up
    create_table :door_glass_families do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :door_glass_families
  end
end
