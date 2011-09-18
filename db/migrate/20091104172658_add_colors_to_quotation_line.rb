class AddColorsToQuotationLine < ActiveRecord::Migration
  def self.up
    add_column :quotation_lines, :exterior_color, :string, :null => true
    add_column :quotation_lines, :interior_color, :string, :null => true
  end

  def self.down
    remove_column :quotation_lines, :interior_color
    remove_column :quotation_lines, :exterior_color
  end
end
