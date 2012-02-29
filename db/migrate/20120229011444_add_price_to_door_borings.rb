class AddPriceToDoorBorings < ActiveRecord::Migration
  def self.up
    add_column :door_borings, :price, :float, :default => 0.0
  end

  def self.down
    remove_column :door_borings, :price
  end
end
