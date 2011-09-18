class CreateQuotationLinesOpenings < ActiveRecord::Migration
  def self.up
    create_table :quotation_lines_openings, :options => 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |t|
      t.column :quotation_line_id,              :integer,             :null => false
      t.column :opening_id,                     :integer,             :null => false
      t.column :sort_order,                     :integer,             :null => false
    end
  end

  def self.down
    drop_table :quotation_lines_openings
  end
end
