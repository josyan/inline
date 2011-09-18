class CreatePreviewImages < ActiveRecord::Migration
  def self.up
    create_table :preview_images do |t|
      t.column :opening_id, :integer, :null => false
      t.column :hinged_on, :string, :default => '', :null => false, :limit => 1
      t.column :image_name, :string
    end
  end

  def self.down
    drop_table :preview_images
  end
end
