class CreateDoorFrames < ActiveRecord::Migration
  def self.up
    create_table :door_frames do |t|
      t.string :name
      t.integer :sections
      t.string :preview_image_name

      t.timestamps
    end
  end

  def self.down
    drop_table :door_frames
  end
end
