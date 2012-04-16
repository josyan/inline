class PopulateDoorPanelFamilies < ActiveRecord::Migration
  def self.up
    SlabMaterial.all.each do |slab_material|
      DoorPanelFamily.create :name => "Famille #{slab_material.name}", :slab_material_id => slab_material.id
    end
  end

  def self.down
    DoorPanelFamily.destroy_all
  end
end
