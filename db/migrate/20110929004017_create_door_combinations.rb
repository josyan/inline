class CreateDoorCombinations < ActiveRecord::Migration
  def self.up
    create_table :door_combinations do |t|
      t.string :name
      t.string :sections
      t.string :preview_image_name
      t.integer :door_frame_id

      t.timestamps
    end
  end

  def self.down
    drop_table :door_combinations
  end
end
