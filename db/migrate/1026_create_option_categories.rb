class CreateOptionCategories < ActiveRecord::Migration
  def self.up
    create_table :option_categories do |t|
      t.column :name, :string
      t.column :description, :string
      t.column :display_order, :integer
    end
  end

  def self.down
    drop_table :option_categories
  end
end
