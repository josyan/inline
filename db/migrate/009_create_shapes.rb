class CreateShapes < ActiveRecord::Migration
  def self.up
    create_table :shapes, :options => 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |t|
      t.column :name,                 :string,        :limit => 50,     :null => false
      t.column :sections_width,       :integer,                         :null => false
      t.column :sections_height,      :integer,                         :null => false
    end
  end

  def self.down
    drop_table :shapes
  end
end
