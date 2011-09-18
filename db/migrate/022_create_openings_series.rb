class CreateOpeningsSeries < ActiveRecord::Migration
  def self.up
    create_table :openings_series, :id => false, :options => 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |t|
      t.column :opening_id,         :integer,       :null => false
      t.column :serie_id,           :integer,       :null => false
    end
  end

  def self.down
    drop_table :openings_series
  end
end
