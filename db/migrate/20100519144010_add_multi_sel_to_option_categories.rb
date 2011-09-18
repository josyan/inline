class AddMultiSelToOptionCategories < ActiveRecord::Migration
  def self.up
    add_column :option_categories, :multiselect, :boolean
    execute 'update option_categories set multiselect=1;'
  end

  def self.down
    remove_column :option_categories, :multiselect
  end
end
