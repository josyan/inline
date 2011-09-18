class AddNewTranslations < ActiveRecord::Migration
  def self.up
    File.open("db/migrate/more-translations.sql").each_line { |line|
      execute line
    }
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration, "Can't remove existing translations because they may have been modified by the user"
  end
end
