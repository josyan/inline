class AddDoorCombinationToDoorLine < ActiveRecord::Migration
  def self.up
    add_column :door_lines, :door_combination_id, :integer
  end

  def self.down
    remove_column :door_lines, :door_combination_id
  end
end
