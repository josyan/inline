class CreateDoorLineSections < ActiveRecord::Migration
  def self.up
    create_table :door_line_sections do |t|
      t.integer :door_line_id
      t.integer :sort_order
      t.integer :door_section_id
      t.integer :door_panel_id
      t.integer :door_glass_id

      t.timestamps
    end
  end

  def self.down
    drop_table :door_line_sections
  end
end
