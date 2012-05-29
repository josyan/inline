class AddSidelightsToShape < ActiveRecord::Migration
  def self.up
    add_column :shapes, :has_left_sidelight, :boolean, :default => false
    add_column :shapes, :has_right_sidelight, :boolean, :default => false
  end

  def self.down
    remove_column :shapes, :has_left_sidelight
    remove_column :shapes, :has_right_sidelight
  end
end
