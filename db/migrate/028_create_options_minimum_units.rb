class CreateOptionsMinimumUnits < ActiveRecord::Migration
  def self.up
    create_table :options_minimum_units, :options => 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |t|
      t.column :description,          :string,      :limit => 50,       :null => false
      t.column :comments,             :text
    end
  end

  def self.down
    drop_table :options_minimum_units
  end
end
