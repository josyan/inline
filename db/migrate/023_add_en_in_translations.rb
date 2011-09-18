class AddEnInTranslations < ActiveRecord::Migration
  def self.up
    add_column :translations, :en, :text
  end

  def self.down
    remove_column :translations, :en
  end
end
