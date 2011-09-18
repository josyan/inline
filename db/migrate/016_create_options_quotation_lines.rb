class CreateOptionsQuotationLines < ActiveRecord::Migration
  def self.up
    create_table :options_quotation_lines, :id => false, :options => 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |t|
      t.column :option_id,                   :integer,       :null => false
      t.column :quotation_line_id,           :integer,       :null => false
    end
  end

  def self.down
    drop_table :options_quotation_lines
  end
end
