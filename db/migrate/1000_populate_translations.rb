class PopulateTranslations < ActiveRecord::Migration
  def self.up
    execute "TRUNCATE TABLE translations;" # prevents having to migrate back to add a new table
    File.open("db/migrate/translations.sql").each_line { |line|
      execute line
    }
  end

  def self.down
    execute "TRUNCATE TABLE translations;"
  end
end
