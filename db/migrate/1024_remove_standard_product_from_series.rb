class RemoveStandardProductFromSeries < ActiveRecord::Migration
  def self.up
    remove_column :series, :is_standard_product
  end

  def self.down
    add_column :series, :is_standard_product, :boolean,  :default => false    
  end
end
