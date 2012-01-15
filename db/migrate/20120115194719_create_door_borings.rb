class CreateDoorBorings < ActiveRecord::Migration
  def self.up
    create_table :door_borings do |t|
      t.string :name
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :door_borings
  end
end
