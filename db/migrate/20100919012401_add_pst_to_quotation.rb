class AddPstToQuotation < ActiveRecord::Migration
  DATAFILE = __FILE__.gsub('.rb', '.sql')
  def self.up
    add_column :quotations, :taxes_pst, :float

    IO.readlines(DATAFILE).join.gsub("\r\n", "\n").split(";\n").each do |s|
      execute(s) unless s == "\n"
    end
  end

  def self.down
    remove_column :quotations, :taxes_pst
    execute 'delete from translations where id >= 496;'
  end
end
