class AddStandardColorToQuotationLine < ActiveRecord::Migration
  def self.up
    add_column :quotation_lines, :standard_interior_color_id, :integer
    add_column :quotation_lines, :standard_exterior_color_id, :integer
  end

  def self.down
    remove_column :quotation_lines, :standard_exterior_color_id
    remove_column :quotation_lines, :standard_interior_color_id
  end
end
