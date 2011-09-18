class CreateDatabaseTranslationFields < ActiveRecord::Migration
  def self.up
    create_table :database_translation_fields, :options => 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |t|
      t.column :table,                :string,    :limit => 50,   :null => false
      t.column :field,                :string,    :limit => 50,   :null => false
    end
  end

  def self.down
    drop_table :database_translation_fields
  end
end