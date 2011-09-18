class RenameTranslationColumnsForRails3 < ActiveRecord::Migration
  def self.up
    rename_column :database_translation_fields, :field, :translation_field_name
    rename_column :database_translations, :field, :translation_field_name
  end

  def self.down
    rename_column :database_translation_fields, :translation_field_name, :field
    rename_column :database_translations, :translation_field_name, :field
  end
end
