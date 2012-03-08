require 'erb'
include Magick

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

  FRAME_THICKNESS = 3.0
  ARROW_SIZE = 5.0
  PIXELS_PER_INCH = 2

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

  def create_image
    temp_file_name = File.join(Rails.root, 'tmp', "image_#{id}.svg")
    final_file_name = File.join(Rails.root, 'public', 'system', 'images', 'doors', "preview_#{id}.png")

    # binding for erb file
    # constants
    frame_thickness = FRAME_THICKNESS
    arrow_size = ARROW_SIZE

    # define canvas for final image
    image_width = (total_width + 30) * PIXELS_PER_INCH
    image_height = (DoorSection::DEFAULT_HEIGHT + 20) * PIXELS_PER_INCH
    canvas = Image.new(image_width, image_height)

    # intialize coordinates
    currentx = 0
    currenty = 0

    # loop on sections
    door_line_sections.each do |door_line_section|

      # get the file to be painted
      if door_line_section.door_panel
        src_image = File.join(Rails.root, 'public', 'images', 'door_panels', File.basename(door_line_section.door_panel.preview_image_name, '.png') + '.svg')
      else
        src_image = File.join(Rails.root, 'public', 'images', 'door_panels', door_line_section.door_section.code + '.svg')
      end

      # load section image
      section_image = Image.read(src_image)[0]

      # resize the section image to fit the dimensions
      section_image.resize! door_line_section.door_section_dimension.value * PIXELS_PER_INCH, DoorSection::DEFAULT_HEIGHT * PIXELS_PER_INCH

      # define offset to paint section
      offsetx_px = currentx * PIXELS_PER_INCH
      offsety_px = 0

      # paint the image on canvas
      canvas.composite! section_image, offsetx_px, offsety_px, OverCompositeOp

      # update coordinates
      currentx += door_line_section.door_section_dimension.value
    end

    # print vertical sizes
    # define values for binding
    section_height = DoorSection::DEFAULT_HEIGHT
    draw_vertical_measurement(canvas, section_height, currenty)

    # initialize offset
    currentx = 0
    # print horizontal sizes
    door_line_sections.each do |door_line_section|
      # define values for binding
      section_width = door_line_section.door_section_dimension.value
      draw_horizontal_measurement(canvas, section_width, currentx)
      # update coordinates
      currentx += door_line_section.door_section_dimension.value
    end

    # write final image
    canvas.write final_file_name

    # delete temp file
    begin
      File.delete temp_file_name
    rescue
      # don't care
    end
  end

  def draw_vertical_measurement(canvas, section_height, currenty)
    # binding for erb file
    # constants
    arrow_size = ARROW_SIZE
    temp_file_name = File.join(Rails.root, 'tmp', "image_#{id}.svg")
    # load erb file and generate svg
    File.open(temp_file_name, 'w') do |f|
      f.write ERB.new(File.read(File.join(Rails.root, 'components', 'misc', 'vertical_size.svg'))).result(binding)
    end

    #load svg file
    size_image = Image.read(temp_file_name)[0]

    # define offset to paint section
    offsetx_px = (total_width + 1) * PIXELS_PER_INCH
    offsety_px = currenty * PIXELS_PER_INCH

    # paint the image on canvas
    canvas.composite! size_image, offsetx_px, offsety_px, OverCompositeOp
  end

  def draw_horizontal_measurement(canvas, section_width, currentx)
    # binding for erb file
    # constants
    arrow_size = ARROW_SIZE
    temp_file_name = File.join(Rails.root, 'tmp', "image_#{id}.svg")
    # load erb file and generate svg
    File.open(temp_file_name, 'w') do |f|
      f.write ERB.new(File.read(File.join(Rails.root, 'components', 'misc', 'horizontal_size.svg'))).result(binding)
    end

    #load svg file
    size_image = Image.read(temp_file_name)[0]

    # define offset to paint section
    offsetx_px = currentx * PIXELS_PER_INCH
    offsety_px = (DoorSection::DEFAULT_HEIGHT + 1) * PIXELS_PER_INCH

    # paint the image on canvas
    canvas.composite! size_image, offsetx_px, offsety_px, OverCompositeOp
  end

end
