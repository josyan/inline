class AddEmphasizeToOption < ActiveRecord::Migration
  def self.up
    add_column :options, :emphasize, :boolean, :default => false
    execute("INSERT INTO `translations` VALUES (618, 'LABEL_EMPHASIZE', 'Mettre l\\'accent sur les documents imprimés sur','', 'Emphasize on printouts','Enfatizar en los listados');")
  end

  def self.down
    remove_column :options, :emphasize
    execute("DELETE FROM `translations` WHERE id=618;")
  end
end