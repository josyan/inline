class AddShapesCorners < ActiveRecord::Migration
  def self.up
    add_column :shapes, :corners, :integer, :null => false, :default => 4
  end

  def self.down
    remove_column :shapes, :corners
  end
end
