class CreateSectionDimensions < ActiveRecord::Migration
  def self.up
    create_table :section_dimensions, :options => 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |t|
      t.column :quotation_line_id,    :integer,                     :null => false
      t.column :sort_order,           :integer,                     :null => false
      t.column :value,                :float,                       :null => false
      t.column :type,                 :string,        :limit => 13, :null => false
    end
  end

  def self.down
    drop_table :section_dimensions
  end
end
