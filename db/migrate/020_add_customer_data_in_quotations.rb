class AddCustomerDataInQuotations < ActiveRecord::Migration
  def self.up
    add_column :quotations, :project_name, :string, :limit => 150
    add_column :quotations, :customer_name, :string, :limit => 150
    add_column :quotations, :customer_address, :string, :limit => 200
    add_column :quotations, :customer_phone, :string, :limit => 50
    add_column :quotations, :customer_fax, :string, :limit => 50
    add_column :quotations, :customer_email, :string, :limit => 50
  end

  def self.down
    remove_column :quotations, :project_name
    remove_column :quotations, :customer_name
    remove_column :quotations, :customer_address
    remove_column :quotations, :customer_phone
    remove_column :quotations, :customer_fax
    remove_column :quotations, :customer_email
  end
end
