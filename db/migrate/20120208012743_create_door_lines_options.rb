class CreateDoorLinesOptions < ActiveRecord::Migration
  def self.up
    create_table :door_line_options do |t|
      t.integer :door_line_id
      t.integer :option_id
      t.float :quantity
      t.timestamps
    end
  end

  def self.down
    drop_table :door_line_options
  end
end
