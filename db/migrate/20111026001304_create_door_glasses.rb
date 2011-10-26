class CreateDoorGlasses < ActiveRecord::Migration
  def self.up
    create_table :door_glasses do |t|
      t.string :name
      t.integer :door_glass_family_id
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :door_glasses
  end
end
