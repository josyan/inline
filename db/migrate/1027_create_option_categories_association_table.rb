class CreateOptionCategoriesAssociationTable < ActiveRecord::Migration
  def self.up
    create_table :option_categories_options do |t|
        t.column :option_category_id, :integer
        t.column :option_id, :integer
    end
    remove_column :option_categories_options, :id 
  end

  def self.down
    drop_table :option_categories_options
  end
end
