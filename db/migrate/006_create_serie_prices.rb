class CreateSeriePrices < ActiveRecord::Migration
  def self.up
    create_table :serie_prices, :options => 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |t|
      t.column :width_id,             :integer,                     :null => false
      t.column :height_id,            :integer,                     :null => false
      t.column :opening_id,           :integer,                     :null => false
      t.column :price,                :float,                       :null => false
    end
  end

  def self.down
    drop_table :dimensions
  end
end
