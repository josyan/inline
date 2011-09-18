class PopulatePricingMethods < ActiveRecord::Migration
  def self.up
    execute "INSERT INTO pricing_methods VALUES (1, 'prix au pied carré', '');"
    execute "INSERT INTO pricing_methods VALUES (2, 'prix au pied de périmètre', '');"
    execute "INSERT INTO pricing_methods VALUES (3, 'prix par section', '');"
    execute "INSERT INTO pricing_methods VALUES (4, 'prix par section ouvrante', '');"
    execute "INSERT INTO pricing_methods VALUES (5, 'prix par section fixe', '');"
    execute "INSERT INTO pricing_methods VALUES (6, 'prix unitaire', '');"
    execute "INSERT INTO pricing_methods VALUES (7, 'prix par coin', '');"
  end

  def self.down
    execute 'TRUNCATE TABLE pricing_methods;'
  end
end
