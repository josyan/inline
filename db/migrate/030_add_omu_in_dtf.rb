class AddOmuInDtf < ActiveRecord::Migration
  def self.up
    execute "INSERT INTO `database_translation_fields` VALUES   (11,'options_minimum_units','description');"
    execute "INSERT INTO `database_translation_fields` VALUES   (12,'options_minimum_units','comments');"
  end

  def self.down
    execute "DELETE FROM `database_translation_fields` WHERE id IN (11, 12)"
  end
end
