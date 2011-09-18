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


  before_destroy :delete_previeww_image

  # constants for drawing
  FRAME_THICKNESS = 3.0
  ARROW_SIZE = 5.0
  PIXELS_PER_INCH = 2

  # returns an array of the options of the quotation line
  def options
    opt = @options_quotation_lines ? @options_quotation_lines.map { |o| o.option } : []
  end

  def create_image(shape)
    temp_file_name = File.join(Rails.root, 'tmp', "image_#{id}.svg")
    final_file_name = File.join(Rails.root, 'public', 'system', 'images', 'previews', "preview_#{id}.png")

    # binding for erb file
    # constants
    frame_thickness = FRAME_THICKNESS
    arrow_size = ARROW_SIZE

    # define canvas for final image
    image_width = (width + 30) * PIXELS_PER_INCH
    image_height = (height + 20) * PIXELS_PER_INCH
    canvas = Image.new(image_width, image_height)

    # coordinates
    currenty = 0

    if (shape.has_upper_transom)
      # intialize coordinates
      currentx = 0

      # define section dimensions for binding in erb
      section_width = get_transom_width(upper_transom_index(shape)) #section_widths[shape.sections_width].value
      section_height = get_transom_height(upper_transom_index(shape)) #section_heights[shape.sections_height].value

      # load svg file
      section_image = get_section_image(upper_transom_index(shape), section_height, section_width)

      # define offset to paint section
      offsetx_px = currentx * PIXELS_PER_INCH
      offsety_px = currenty * PIXELS_PER_INCH

      # paint the image on canvas
      canvas.composite! section_image, offsetx_px, offsety_px, OverCompositeOp
      # update coordinates
      currenty += section_height        
    end
    
    # loop on rows
    0.upto(shape.sections_height - 1) do |h|

      # intialize coordinates
      currentx = 0

      # loop on columns
      0.upto(shape.sections_width - 1) do |w|

        # define section dimensions for binding in erb
        section_width = get_section_width(w+1)
        section_height = get_section_height(h+1)

        # load svg file
        section_image = get_section_image(h * shape.sections_width + w + 1, section_height, section_width)

        # define offset to paint section
        offsetx_px = currentx * PIXELS_PER_INCH
        offsety_px = currenty * PIXELS_PER_INCH

        # paint the image on canvas
        canvas.composite! section_image, offsetx_px, offsety_px, OverCompositeOp
        
        # update coordinates
        currentx += section_width
      end

      # update coordinates
      currenty += section_height
      
    end

    if (shape.has_lower_transom)
      # intialize coordinates
      currentx = 0

      # define section dimensions for binding in erb
      section_width = get_transom_width(lower_transom_index(shape))
      section_height = get_transom_height(lower_transom_index(shape))

      # load svg file
      section_image = get_section_image(lower_transom_index(shape), section_height, section_width)

      # define offset to paint section
      offsetx_px = currentx * PIXELS_PER_INCH
      offsety_px = currenty * PIXELS_PER_INCH

      # paint the image on canvas
      canvas.composite! section_image, offsetx_px, offsety_px, OverCompositeOp
      # update coordinates
      currenty += section_height        
    end

    # initialize offset
    currenty = 0
    if (shape.has_upper_transom)
      # define values for binding
      section_height = get_transom_height(upper_transom_index(shape))
      draw_vertical_measurement(canvas, section_height, currenty)
      # update coordinates
      currenty += section_height
    end
    # print vertical sizes
    1.upto(shape.sections_height) do |h|
      # define values for binding
      section_height = get_section_height(h)
      draw_vertical_measurement(canvas, section_height, currenty)
      # update coordinates
      currenty += section_height
    end
    if (shape.has_lower_transom)
      # define values for binding
      section_height = get_transom_height(lower_transom_index(shape))
      draw_vertical_measurement(canvas, section_height, currenty)
      # update coordinates
      currenty += section_height
    end
    
    # initialize offset
    currentx = 0

    # print horizontal sizes
    1.upto(shape.sections_width) do |w|
      # define values for binding
      section_width = get_section_width(w)
      draw_horizontal_measurement(canvas, section_width, currentx)
      # update coordinates
      currentx += section_width
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

  def get_image_size
    return (width + 30) * PIXELS_PER_INCH, (height + 20) * PIXELS_PER_INCH
  end

  def upper_transom_index(shape)
    (shape.sections_width * shape.sections_height + 1)
  end

  def lower_transom_index(shape)
    (shape.sections_width * shape.sections_height + 2)
  end

  protected

  def get_section_width(idx)
    section_widths.select {|t| t.sort_order == idx}.first.value
  end

  def get_section_height(idx)
    section_heights.select {|t| t.sort_order == idx}.first.value
  end
  
  def get_transom_width(idx)
    section_widths.select {|t| t.sort_order == idx}.first.value
  end  
  
  def get_transom_height(idx)
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
    offsetx_px = (width + 1) * PIXELS_PER_INCH
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
    offsety_px = (height + 1) * PIXELS_PER_INCH

    # paint the image on canvas
    canvas.composite! size_image, offsetx_px, offsety_px, OverCompositeOp    
  end

  def delete_previeww_image
    # delete the line image
    begin
      File.delete File.join(Rails.root, 'public', 'system', 'images', 'previews', "preview_#{id}.png")
    rescue
      # no problem if file does not exist
    end
  end

end
