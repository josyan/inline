class AddModuleTypeToOptions < ActiveRecord::Migration
  def self.up
    add_column :options, :module_type_id, :integer, :default => 1
  end

  def self.down
    remove_column :options, :module_type_id
  end
end
