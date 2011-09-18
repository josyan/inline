class AddTaxNumbersToCompany < ActiveRecord::Migration
  DATAFILE = __FILE__.gsub('.rb', '.sql')

  def self.up
    add_column :companies, :gst_number, :string
    add_column :companies, :pst_number, :string

    IO.readlines(DATAFILE).join.gsub("\r\n", "\n").split(";\n").each do |s|
      execute(s) unless s == "\n"
    end

  end

  def self.down
    remove_column :companies, :pst_number
    remove_column :companies, :gst_number
    execute 'delete from translations where id >= 494;'
  end
end
