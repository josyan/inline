class AddTransomsToShape < ActiveRecord::Migration
  def self.up
    add_column :shapes, :has_upper_transom, :boolean, :default => false
    add_column :shapes, :has_lower_transom, :boolean, :default => false
  end

  def self.down
    remove_column :shapes, :has_lower_transom
    remove_column :shapes, :has_upper_transom
  end
end
