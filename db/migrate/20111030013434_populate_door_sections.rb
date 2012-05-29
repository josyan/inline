class PopulateDoorSections < ActiveRecord::Migration
  def self.up
    DoorSection.create :name => "L", :code => "L"
    DoorSection.create :name => "LP", :code => "LP"
    DoorSection.create :name => "SL", :code => "SL"
    DoorSection.create :name => "SLO", :code => "SLO"
    DoorSection.create :name => "SLF", :code => "SLF"
  end

  def self.down
    DoorSection.delete_all
  end
end
