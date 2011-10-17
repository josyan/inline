class CreateSlabMaterials < ActiveRecord::Migration
  def self.up
    create_table :slab_materials do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :slab_materials
  end
end
