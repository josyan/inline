class AddPriceCheckMessages < ActiveRecord::Migration
  def self.up
    File.open("db/migrate/add_price_check_messages.sql").each_line { |line|
      execute line unless line.empty?
    }
  end

  def self.down
    if RAILS_ENV == 'production'
      raise ActiveRecord::IrreversibleMigration, "Can't remove existing translations because they may have been modified by the user"
    else
      execute 'delete from translations where id >= 390;'
    end
  end
end
