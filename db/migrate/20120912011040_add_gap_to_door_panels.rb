class AddGapToDoorPanels < ActiveRecord::Migration
  def self.up
    add_column :door_panels, :gap, :string
  end

  def self.down
    remove_column :door_panels, :gap
  end
end
