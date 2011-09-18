class Dimension < ActiveRecord::Base
  belongs_to :serie

  validates_presence_of :serie_id
  validates_presence_of :value
end
