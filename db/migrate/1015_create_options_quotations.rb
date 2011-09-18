class CreateOptionsQuotations < ActiveRecord::Migration
  def self.up
    create_table :options_quotations, :options => 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |t|
      t.column :option_id,                   :integer,       :null => false
      t.column :quotation_id,                :integer,       :null => false
      t.column :quantity,                    :float,         :null => false, :default => 1
    end
  end

  def self.down
    drop_table :options_quotations
  end
end
