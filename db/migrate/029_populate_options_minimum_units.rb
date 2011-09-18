class PopulateOptionsMinimumUnits < ActiveRecord::Migration
  def self.up
    execute "INSERT INTO options_minimum_units VALUES (1, 'par fenêtre', '');"
    execute "INSERT INTO options_minimum_units VALUES (2, 'par section', '');"
    execute "INSERT INTO options_minimum_units VALUES (3, 'par vitre', '');"
  end

  def self.down
    execute 'TRUNCATE TABLE options_minimum_units;'
  end
end
