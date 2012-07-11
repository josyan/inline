class AddCopyQuotationTranslation < ActiveRecord::Migration
  DATAFILE = __FILE__.gsub('.rb', '.sql')
  def self.up
    IO.readlines(DATAFILE).join.gsub("\r\n", "\n").split(";\n").each do |s|
      execute(s) unless s == "\n"
    end
    execute("update translations set translation_key='BUTTON_NEXT>>' where id=101")
  end

  def self.down
    execute 'delete from translations where id >= 514;'
  end

end
