class PopulateModuleTypes < ActiveRecord::Migration
  def self.up
    ModuleType.create :name => 'Fenêtre', :gender => 'F'
    ModuleType.create :name => 'Porte', :gender => 'F'
  end

  def self.down
    ModuleType.delete_all
  end
end
