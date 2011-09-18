class AddPhotoToOptions < ActiveRecord::Migration
  def self.up
    add_column :options, :photo_file_name, :string # Original filename
    add_column :options, :photo_content_type, :string # Mime type
    add_column :options, :photo_file_size, :integer # File size in bytes
  end

  def self.down
    remove_column :options, :logo_file_name
    remove_column :options, :logo_content_type
    remove_column :options, :logo_file_size
  end
end
