class RemoveDoorSectionDimensions < ActiveRecord::Migration
  def self.up
    drop_table :door_section_dimensions
  end

  def self.down
    create_table :door_section_dimensions do |t|
      t.integer :door_section_id
      t.float :value

      t.timestamps
    end
  end
end
