class AddPreviewImageNameInOpenings < ActiveRecord::Migration
  def self.up
    add_column :openings, :preview_image_name, :string, :limit => 100
  end

  def self.down
    remove_column :openings, :preview_image_name
  end
end
