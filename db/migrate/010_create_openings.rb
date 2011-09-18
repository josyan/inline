class CreateOpenings < ActiveRecord::Migration
  def self.up
    create_table :openings, :options => 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |t|
      t.column :name,                 :string,        :limit => 50,     :null => false
      t.column :abbreviation,         :string,        :limit => 5,      :null => false
    end
  end

  def self.down
    drop_table :openings
  end
end
