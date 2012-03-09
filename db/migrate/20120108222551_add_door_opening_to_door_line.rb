class AddDoorOpeningToDoorLine < ActiveRecord::Migration
  def self.up
    add_column :door_lines, :door_opening_id, :integer
  end

  def self.down
    remove_column :door_lines, :door_opening_id
  end
end
