class CreateDoorLines < ActiveRecord::Migration
  def self.up
    create_table :door_lines do |t|
      t.integer :quotation_id
      t.integer :door_frame_id
      t.integer :quantity
      t.float :price

      t.timestamps
    end
  end

  def self.down
    drop_table :door_lines
  end
end
