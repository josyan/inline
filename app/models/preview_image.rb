class PreviewImage < ActiveRecord::Base
  belongs_to :opening
  
  LEFT = 'L'
  RIGHT = 'R'
  NONE = 'N'

  validates_presence_of :image_name, :hinged_on
  validates_inclusion_of :hinged_on, :in => %w( L R N )
end
