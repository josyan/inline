class AddDeliveryAddressToQuotation < ActiveRecord::Migration
  def self.up
    add_column :quotations, :delivery_address, :string
  end

  def self.down
    remove_column :quotations, :delivery_address
  end
end
