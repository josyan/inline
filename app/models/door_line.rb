class DoorLine < ActiveRecord::Base
  belongs_to :quotation
  belongs_to :door_frame
  belongs_to :door_combination
  belongs_to :frame_profile
  belongs_to :slab_material
  has_many :door_line_sections, :order => 'sort_order', :dependent => :destroy
  belongs_to :door_opening
  belongs_to :door_boring
  has_many :door_line_options, :dependent => :destroy

  def update_price
    self.price = 0

    # door frame
    self.price += door_frame.price

    # door combination
    self.price += door_combination.price

    # frame profile
    self.price += frame_profile.price

    # slab material
    self.price += slab_material.price

    # door opening
    self.price += door_opening.price

    # door boring
    self.price += door_boring.price

    # door line sections
    door_line_sections.each do |door_line_section|
      self.price += door_line_section.price
    end

    # door line options
    door_line_options.each do |door_line_option|
      self.price += door_line_option.price
    end

    self.save
  end

  def total_width
    width = 0
    door_line_sections.each do |door_line_section|
      width += door_line_section.door_section_dimension.value
    end
    width
  end

end
