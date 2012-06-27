class DoorSection < ActiveRecord::Base
  include Priceable

  has_and_belongs_to_many :door_panels

  def openable?
    ['SL', 'SLO'].include? code
  end

end
