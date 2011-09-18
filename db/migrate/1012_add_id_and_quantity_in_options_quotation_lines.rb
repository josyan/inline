class AddIdAndQuantityInOptionsQuotationLines < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE options_quotation_lines
             ADD COLUMN id INTEGER  NOT NULL AUTO_INCREMENT AFTER quotation_line_id,
             ADD COLUMN quantity INTEGER  NOT NULL DEFAULT 1 AFTER id,
             ADD PRIMARY KEY (id)"
  end

  def self.down
    execute "ALTER TABLE options_quotation_lines DROP COLUMN id,
             DROP COLUMN quantity"
  end
end
