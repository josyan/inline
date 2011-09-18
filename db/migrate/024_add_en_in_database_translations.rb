class AddEnInDatabaseTranslations < ActiveRecord::Migration
  def self.up
    add_column :database_translations, :en, :text
  end

  def self.down
    remove_column :database_translations, :en
  end
end
