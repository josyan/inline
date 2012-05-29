require 'RMagick'
require 'erb'
include Magick

class QuotationLine < ActiveRecord::Base
  belongs_to :quotation
  belongs_to :serie
  belongs_to :shape
  has_many :quotation_lines_openings, :order => 'sort_order', :dependent => :destroy
  has_many :options_quotation_lines, :dependent => :destroy
  has_many :section_heights, :dependent => :destroy
  has_many :section_widths, :dependent => :destroy
  
  belongs_to :standard_interior_color, :class_name => "ProductColor" 
  belongs_to :standard_exterior_color, :class_name => "ProductColor" 

  validates_presence_of :width, :height, :serie_id, :quantity
  validates_numericality_of :width, :height, :quantity


  before_destroy :delete_preview_image

  # constants for drawing
  FRAME_THICKNESS = 3.0
  ARROW_SIZE = 5.0
  PIXELS_PER_INCH = 2

  def create_image(shape)
    temp_file_name = File.join(Rails.root, 'tmp', "image_#{id}.svg")
    final_file_name = File.join(Rails.root, 'public', 'system', 'images', 'previews', "preview_#{id}.png")

    # binding for erb file
    # constants
    frame_thickness = FRAME_THICKNESS
    arrow_size = ARROW_SIZE

    # define canvas for final image
    image_width = (width + 40) * PIXELS_PER_INCH
    image_height = (height + 30) * PIXELS_PER_INCH
    canvas = Image.new(image_width, image_height)

    # coordinates
    current_x = 0
    current_y = 0
    left_sidelight_width = 0
    upper_transom_height = 0

    # draw upper transom
    if shape.has_upper_transom?
      # initialize coordinates
      current_x = 0

      section_height, section_width = draw_special_section(canvas, current_x, current_y, upper_transom_index(shape))
      # update coordinates
      current_y += section_height
      upper_transom_height = section_height
    end

    #draw left sidelight
    if shape.has_left_sidelight?
      # initialize coordinates
      current_x = 0

      section_height, section_width = draw_special_section(canvas, current_x, current_y, left_sidelight_index(shape))
      # update coordinates
      current_x += section_width
      left_sidelight_width = section_width
    end
    # loop on rows
    if true

    0.upto(shape.sections_height - 1) do |h|

      # initialize coordinates
      current_x = left_sidelight_width

      # loop on columns
      0.upto(shape.sections_width - 1) do |w|

        # define section dimensions for binding in erb
        section_width = get_section_width(w+1)
        section_height = get_section_height(h+1)

        # load svg file
        section_image = get_section_image(h * shape.sections_width + w + 1, section_height, section_width)

        # define offset to paint section
        offset_x_px = current_x * PIXELS_PER_INCH
        offset_y_px = current_y * PIXELS_PER_INCH

        # paint the image on canvas
        canvas.composite! section_image, offset_x_px, offset_y_px, OverCompositeOp

        # update coordinates
        current_x += section_width
      end

      # update coordinates
      current_y += section_height

    end

    end

     #draw right sidelight
    if shape.has_right_sidelight?
      # initialize coordinates
      current_y = upper_transom_height

      section_height, section_width = draw_special_section(canvas, current_x, current_y, right_sidelight_index(shape))
      # update coordinates
      current_x += section_width
    end

    if shape.has_lower_transom?
      # initialize coordinates
      current_x = 0

      section_height, section_width = draw_special_section(canvas, current_x, current_y, lower_transom_index(shape))

      # update coordinates
      current_y += section_height
    end

    # initialize offset
    current_x = 0
    if shape.has_left_sidelight?
      # define values for binding
      section_width = get_section_width(left_sidelight_index(shape))
      draw_horizontal_measurement(canvas, section_width, current_x)
      # update coordinates
      current_x += section_width
    end

    # print horizontal sizes
    1.upto(shape.sections_width) do |w|
      # define values for binding
      section_width = get_section_width(w)
      draw_horizontal_measurement(canvas, section_width, current_x)
      # update coordinates
      current_x += section_width
    end
    if shape.has_right_sidelight?
      # define values for binding
      section_width = get_section_width(right_sidelight_index(shape))
      draw_horizontal_measurement(canvas, section_width, current_x)
      # update coordinates
      current_x += section_width
    end

if true
    # initialize offset
    current_y = 0
    if shape.has_upper_transom?
      # define values for binding
      section_height = get_section_height(upper_transom_index(shape))
      draw_vertical_measurement(canvas, section_height, current_y)
      # update coordinates
      current_y += section_height
    end
    # print vertical sizes
    1.upto(shape.sections_height) do |h|
      # define values for binding
      section_height = get_section_height(h)
      draw_vertical_measurement(canvas, section_height, current_y)
      # update coordinates
      current_y += section_height
    end
    if shape.has_lower_transom?
      # define values for binding
      section_height = get_section_height(lower_transom_index(shape))
      draw_vertical_measurement(canvas, section_height, current_y)
      # update coordinates
      current_y += section_height
    end
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

  def draw_special_section(canvas, current_x, current_y, index)
    section_width = get_section_width(index)
    section_height = get_section_height(index)
    logger.info "draw special section WxH #{section_width}, #{section_height}"

    # load svg file
    section_image = get_section_image(index, section_height, section_width)

    # define offset to paint section
    offset_x_px = current_x * PIXELS_PER_INCH
    offset_y_px = current_y * PIXELS_PER_INCH

    logger.info "draw special section #{current_x}, #{current_y}, @ #{offset_x_px}, #{offset_y_px} index #{index}"
    # paint the image on canvas
    canvas.composite! section_image, offset_x_px, offset_y_px, OverCompositeOp
    return section_height, section_width
  end

  def get_image_size
    return (width + 30) * PIXELS_PER_INCH, (height + 20) * PIXELS_PER_INCH
  end

  def upper_transom_index(shape)
    (shape.sections_width * shape.sections_height + 1)
  end

  def lower_transom_index(shape)
    (shape.sections_width * shape.sections_height + 2)
  end

  def left_sidelight_index(shape)
    (shape.sections_width * shape.sections_height + 3)
  end

  def right_sidelight_index(shape)
    (shape.sections_width * shape.sections_height + 4)
  end

  def applies_to(opening, apply_to)
    case apply_to
      when 0
        return opening.openable == false
      when 1
        return opening.openable == true
      when 2
        true
    end
  end

  def compute_minimum_section_area(section_area, option, opening)
    # don't count this area if the opening isn't applicable (eg, we're only counting fixed or openable openings)
    return 0 if option.apply_to != 2 && !applies_to(opening, option.apply_to)
    section_area = option.minimum_quantity if section_area < option.minimum_quantity
    section_area
  end

  def compute_minimum_glass_area(section_area, option, opening)
    # don't count this area if the opening isn't applicable (eg, we're only counting fixed or openable openings)
    return 0 if option.apply_to != 2 && !applies_to(opening, option.apply_to)

    glasses_quantity = (opening.glasses_quantity || 1)
    glass_area = section_area / glasses_quantity
    glass_area = option.minimum_quantity if glass_area < option.minimum_quantity
    glass_area * glasses_quantity
  end

  protected

  def get_section_width(idx)
    section_widths.select {|t| t.sort_order == idx}.first.value
  end

  def get_section_height(idx)
    section_heights.select {|t| t.sort_order == idx}.first.value
  end
  

  def get_opening(idx)
    quotation_lines_openings.select {|o| o.sort_order == idx}.first.opening
  end

  def get_section_image(cpt_opening, section_height, section_width)
    # binding for erb file
    # constants
    frame_thickness = FRAME_THICKNESS
    arrow_size = ARROW_SIZE
    temp_file_name = File.join(Rails.root, 'tmp', "image_#{id}.svg")
    # load erb file for section and generate scaled svg file
    image_file_name = File.basename(get_opening(cpt_opening).preview_image_name, '.png') + '.svg'
    File.open(temp_file_name, 'w') do |f|
      f.write ERB.new(File.read(File.join(Rails.root, 'components', 'openings', image_file_name))).result(binding)
    end

    # load svg file
    section_image = Image.read(temp_file_name)[0]
  end

  def draw_vertical_measurement(canvas, section_height, current_y)
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
    offset_x_px = (width + 1) * PIXELS_PER_INCH
    offset_y_px = current_y * PIXELS_PER_INCH

    # paint the image on canvas
    canvas.composite! size_image, offset_x_px, offset_y_px, OverCompositeOp
  end
  
  def draw_horizontal_measurement(canvas, section_width, current_x)
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
    offset_x_px = current_x * PIXELS_PER_INCH
    offset_y_px = (height + 1) * PIXELS_PER_INCH

    # paint the image on canvas
    canvas.composite! size_image, offset_x_px, offset_y_px, OverCompositeOp
  end

  def delete_preview_image
    # delete the line image
    begin
      File.delete File.join(Rails.root, 'public', 'system', 'images', 'previews', "preview_#{id}.png")
    rescue
      # no problem if file does not exist
    end
  end

end
