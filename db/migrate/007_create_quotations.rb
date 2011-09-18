class CreateQuotations < ActiveRecord::Migration
  def self.up
    create_table :quotations, :options => 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |t|
      t.column :description,          :string,      :limit => 50,       :null => false
      t.column :comments,             :text
    end
  end

  def self.down
    drop_table :quotations
  end
end
