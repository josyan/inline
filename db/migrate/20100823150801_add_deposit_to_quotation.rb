class AddDepositToQuotation < ActiveRecord::Migration
  DATAFILE = __FILE__.gsub('.rb', '.sql')

  LAST_TRANSLATION_ID = 486
  def self.up
    add_column :quotations, :deposit, :float
    IO.readlines(DATAFILE).join.gsub("\r\n", "\n").split(";\n").each do |s|
      execute(s) unless s == "\n"
    end
  end

  def self.down
    remove_column :quotations, :deposit
    execute 'delete from translations where id >= 486;'
  end
end
