class AddLogoUploadFields < ActiveRecord::Migration
  def self.up
    rename_column :companies, :logo, :logo_file_name
    add_column :companies, :logo_content_type, :string # Mime type
    add_column :companies, :logo_file_size, :integer # File size in bytes
  end

  def self.down
    rename_column :companies, :logo_file_name, :logo
    remove_column :companies, :logo_content_type
    remove_column :companies, :logo_file_size
  end
end
