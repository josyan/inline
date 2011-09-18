class AddTransportTaxesDiscountInQuotations < ActiveRecord::Migration
  def self.up
    add_column :quotations, :transport, :float, :null => false, :default => 0
    add_column :quotations, :discount, :float, :null => false, :default => 0
    add_column :quotations, :taxes, :float, :null => false, :default => 0
  end

  def self.down
    remove_column :quotations, :transport
    remove_column :quotations, :discount
    remove_column :quotations, :taxes
  end
end
