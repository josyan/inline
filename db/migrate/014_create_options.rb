class CreateOptions < ActiveRecord::Migration
  def self.up
    create_table :options, :options => 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |t|
      t.column :description,          :string,      :limit => 50,       :null => false
      t.column :comments,             :text
      t.column :pricing_method_id,    :integer,     :null => false
      t.column :price,                :float,       :null => false
    end
  end

  def self.down
    drop_table :options
  end
end
