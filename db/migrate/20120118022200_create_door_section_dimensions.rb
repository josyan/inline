class CreateDoorSectionDimensions < ActiveRecord::Migration
  def self.up
    create_table :door_section_dimensions do |t|
      t.integer :door_section_id
      t.float :value

      t.timestamps
    end
  end

  def self.down
    drop_table :door_section_dimensions
  end
end
