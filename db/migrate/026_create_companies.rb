class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies, :options => 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |t|
      t.column :name,         :string,        :limit => 100,          :null => false
      t.column :address,      :string,        :limit => 200
      t.column :phone,        :string,        :limit => 50
      t.column :fax,          :string,        :limit => 50
      t.column :logo,         :string,        :limit => 100
    end
  end

  def self.down
    drop_table :companies
  end
end
