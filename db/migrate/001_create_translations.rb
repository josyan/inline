class CreateTranslations < ActiveRecord::Migration
  def self.up
    create_table :translations, :options => 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |t|
      t.column :translation_key,      :string,    :limit => 100,    :null => false
      t.column :fr,                   :text
      t.column :comments,             :text
    end
  end

  def self.down
    drop_table :translations
  end
end