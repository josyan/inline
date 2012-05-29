class PopulateDoorCombinationsDoorOpenings < ActiveRecord::Migration
  def self.up
    DoorCombination.find(1).door_opening_ids = [69, 70, 71, 72]
    DoorCombination.find(2).door_opening_ids = [61, 62, 63, 64]
    DoorCombination.find(3).door_opening_ids = [31, 32, 33, 34]
    DoorCombination.find(4).door_opening_ids = [65, 66, 67, 68]
    DoorCombination.find(5).door_opening_ids = [61, 62, 63, 64]
    DoorCombination.find(6).door_opening_ids = [31, 32, 33, 34]
    DoorCombination.find(7).door_opening_ids = [65, 66, 67, 68]
    DoorCombination.find(8).door_opening_ids = [61, 62, 63, 64]
    DoorCombination.find(9).door_opening_ids = [31, 32, 33, 34]
    DoorCombination.find(10).door_opening_ids = [65, 66, 67, 68]
    DoorCombination.find(11).door_opening_ids = [41, 42]
    DoorCombination.find(12).door_opening_ids = [21, 22]
    DoorCombination.find(13).door_opening_ids = [39, 40]
    DoorCombination.find(14).door_opening_ids = [51, 52]
    DoorCombination.find(15).door_opening_ids = [23, 24, 25, 26, 35, 36, 37, 38, 27, 28, 29, 30]
    DoorCombination.find(16).door_opening_ids = [53, 54, 55, 56, 57, 58, 59, 60]
    DoorCombination.find(17).door_opening_ids = [5, 6, 7, 8, 9, 10, 11, 12]
    DoorCombination.find(18).door_opening_ids = [43, 44, 45, 46, 47, 48, 49, 50]
    DoorCombination.find(19).door_opening_ids = [53, 54, 55, 56, 57, 58, 59, 60]
    DoorCombination.find(20).door_opening_ids = [5, 6, 7, 8, 9, 10, 11, 12]
    DoorCombination.find(21).door_opening_ids = [43, 44, 45, 46, 47, 48, 49, 50]
    DoorCombination.find(22).door_opening_ids = [53, 54, 55, 56, 57, 58, 59, 60]
    DoorCombination.find(23).door_opening_ids = [5, 6, 7, 8, 9, 10, 11, 12]
    DoorCombination.find(24).door_opening_ids = [43, 44, 45, 46, 47, 48, 49, 50]
    DoorCombination.find(25).door_opening_ids = [1, 2, 3, 4, 17, 18, 19, 20, 13, 14, 15, 16]
  end

  def self.down
    DoorCombination.each do |dc|
      dc.door_openings.clear
    end
  end
end
