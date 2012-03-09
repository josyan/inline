class AddPriceToSlabMaterials < ActiveRecord::Migration
  def self.up
    add_column :slab_materials, :price, :float, :default => 0.0
  end

  def self.down
    remove_column :slab_materials, :price
  end
end
