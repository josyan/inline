class ApplyPricingMethodToOpenings < ActiveRecord::Migration
  def self.up
    add_column :options, :apply_to, :integer,  :default => 0, :null => false
    execute("update options set apply_to=2;")
  end

  def self.down
  	remove_column :options, :apply_to
  end
end
