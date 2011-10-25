class CreateDoorGlassFamilies < ActiveRecord::Migration
  def self.up
    create_table :door_glass_families do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :door_glass_families
  end
end
