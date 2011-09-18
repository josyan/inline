class CreateDimensions < ActiveRecord::Migration
  def self.up
    create_table :dimensions, :options => 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |t|
      t.column :serie_id,             :integer,                     :null => false
      t.column :value,                :float,                       :null => false
      t.column :type,                 :string,        :limit => 6,  :null => false
    end
  end

  def self.down
    drop_table :dimensions
  end
end
