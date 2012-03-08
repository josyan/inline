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

  def create_image
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

end
