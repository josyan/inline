class AddColorInfoToDoorLines < ActiveRecord::Migration
  def self.up
    add_column :door_lines, :exterior_color, :string, :null => true
    add_column :door_lines, :interior_color, :string, :null => true
    add_column :door_lines, :standard_interior_color_id, :integer
    add_column :door_lines, :standard_exterior_color_id, :integer
  end

  def self.down
    remove_column :door_lines, :standard_exterior_color_id
    remove_column :door_lines, :standard_interior_color_id
    remove_column :door_lines, :interior_color
    remove_column :door_lines, :exterior_color
  end
end
