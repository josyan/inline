class AddPriceToDoorOpenings < ActiveRecord::Migration
  def self.up
    add_column :door_openings, :price, :float, :default => 0.0
  end

  def self.down
    remove_column :door_openings, :price
  end
end
