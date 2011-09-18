class SeriePrice < ActiveRecord::Base
  belongs_to :width
  belongs_to :height
  belongs_to :opening

  validates_presence_of :width_id, :height_id, :price, :opening_id
  validates_numericality_of :price
  
  def display_string
    "#{width.value} x #{height.value}"
  end
end
