class PopulateSlabMaterials < ActiveRecord::Migration
  def self.up
    SlabMaterial.create :name => 'Acier'
    SlabMaterial.create :name => 'Fibre de verre'
  end

  def self.down
    SlabMaterial.delete_all
  end
end
