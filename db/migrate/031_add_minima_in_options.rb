class AddMinimaInOptions < ActiveRecord::Migration
  def self.up
    add_column :options, :minimum_quantity, :float, :null => false, :default => 0
    add_column :options, :options_minimum_unit_id, :integer, :null => false, :default => 1
  end

  def self.down
    remove_column :options, :minimum_quantity
    remove_column :options, :options_minimum_unit_id
  end
end
