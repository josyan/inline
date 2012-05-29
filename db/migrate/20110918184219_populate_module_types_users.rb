class PopulateModuleTypesUsers < ActiveRecord::Migration
  def self.up
    module_type = ModuleType.first(:conditions => { :name => 'Fenêtre' })
    User.all.each do |user|
      user.module_types << module_type
    end
  end

  def self.down
    User.all.each do |user|
      user.module_types.clear
    end
  end
end
