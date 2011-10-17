class AddSlabMaterialToDoorLine < ActiveRecord::Migration
  def self.up
    add_column :door_lines, :slab_material_id, :integer
  end

  def self.down
    remove_column :door_lines, :slab_material_id
  end
end
