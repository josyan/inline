class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers, :force => true do |t|
      t.column :name,     :string, :limit => 150, :null => false
      t.column :address,  :string, :limit => 200 
      t.column :phone,    :string, :limit => 50
      t.column :fax,      :string, :limit => 50 
      t.column :email,    :string, :limit => 50 
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :customers
  end
end
