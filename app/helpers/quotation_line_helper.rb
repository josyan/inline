module QuotationLineHelper

  def select_opening(section, selected)
    output = "<div class=\"opening_list_caller\">"
    output << hidden_field_tag("openings[#{section}]", selected)
    if selected == 0
      output << image_tag('openings/none.png', :onclick => "$('opening_list_#{section}').toggle();", :id => "opening_pic_#{section}")
    else
      output << image_tag('openings/' + Opening.find(selected).preview_image_name, :onclick => "$('opening_list_#{section}').toggle();", :id => "opening_pic_#{section}")
    end
    # non IE version
    output << "<!--[if !IE]> <!-->"
    output << "<div id=\"opening_list_#{section}\" class=\"opening_list\" style=\"display: none;\">"
    @quotation_line.serie.openings.each do |o|
      output << "<div class=\"image\" onmouseover=\"this.addClassName('hover')\" onmouseout=\"this.removeClassName('hover')\" onclick=\"$('openings_#{section}').value = #{o.id}; $('opening_pic_#{section}').src = '/images/openings/#{o.preview_image_name}'; $('opening_list_#{section}').toggle();\">"
      output << image_tag('openings/' + o.preview_image_name)
      output << "<br/>" + o.tr_abbreviation
      output << "</div>"
    end
    output << "</div>"
    output << "<!--<![endif]-->"
    # IE version
    output << "<!--[if IE]>"
    output << "<br/>"
    js = "pics_#{section} = {};"
    js << "pics_#{section}.img_0 = '/images/openings/none.png';"
    @quotation_line.serie.openings.each do |o|
      js << "pics_#{section}.img_#{o.id} = '/images/openings/#{o.preview_image_name}';"
    end
    output << javascript_tag(js)
    output << select_tag("openings_combo_#{section}", options_for_select([['----', 0]] + @quotation_line.serie.openings.map { |o| ["#{o.name} (#{o.abbreviation})", o.id] }, selected), :onchange => "$('openings_#{section}').value = this.value; $('opening_pic_#{section}').src = pics_#{section}['img_' + this.value];")
    output << "<![endif]-->"
    output << "</div>"
    output.html_safe
  end
  
  def size_tag_helper(width_or_height, idx)
      if @quotation_line.serie.is_standard_product?
        select_tag("section_#{width_or_height}[#{idx}]", options_from_collection_for_select(@serie.width_or_height, "value", "value")) 
      else
        text_field_tag "section_#{width_or_height}[#{idx}]", @section_width_or_height[idx.to_s], :size => 6 
      end
  end
  
  def calculate_one_option_price(option, openings, shape)
    option_price = 0.0
      case option.pricing_method_id
        when 1 # price per square foot
          option_price = calc_one_option_price_per_sq_ft(openings, option, shape)
        when 2 # price by foot of perimeter
          option_price = calc_one_option_price_per_ft_of_perimeter(openings, option, shape)
        when 3 # price per section
          option_price = option.price * openings.length
        when 4 # price per opening section
          nb_sections = openings.values.count{|v| Opening.find(v.to_i).openable}
          option_price = option.price * nb_sections
        when 5 # price by fixed section
          nb_sections = openings.values.count{|v| !Opening.find(v.to_i).openable}
          option_price = option.price * nb_sections
        when 6 # unit price
          option_price = option.price
        when 7 # price per corner
          option_price = option.price * shape.corners
        when 8 # price per total width
          option_price = option.price * (@total_width / 12.0).round
      end
      option_price
    end

    def calc_one_option_price_per_ft_of_perimeter(openings, option, shape)
      if option.minimum_quantity != 0
        case option.options_minimum_unit_id
          when 1 # per window
            perimeter = (@total_width * 2 + @total_height * 2) / 12
            perimeter = option.minimum_quantity if perimeter < option.minimum_quantity
          when 2 # per section
            perimeter = 0
            1.upto(shape.sections_height) do |r|
              1.upto(shape.sections_width) do |c|
                section_perimeter = (@real_height[r] * 2 + @real_width[c] * 2) / 12
                section_perimeter = option.minimum_quantity if section_perimeter < option.minimum_quantity
                perimeter += section_perimeter
              end
            end
            if shape.has_upper_transom?
              section_perimeter = (@section_height[@upper_transom_index].to_i * 2 + @total_width * 2) / 12
              section_perimeter = option.minimum_quantity if section_perimeter < option.minimum_quantity
              perimeter += section_perimeter
            end
            if shape.has_lower_transom?
              section_perimeter = (@section_height[@lower_transom_index].to_i * 2 + @total_width * 2) / 12
              section_perimeter = option.minimum_quantity if section_perimeter < option.minimum_quantity
              perimeter += section_perimeter
            end
            if shape.has_left_sidelight?
              index = @left_sidelight_index
              section_perimeter = (@section_height[index].to_i * 2 + @section_width[index] * 2) / 12
              section_perimeter = option.minimum_quantity if section_perimeter < option.minimum_quantity
              perimeter += section_perimeter
            end
            if shape.has_right_sidelight?
              index = @right_sidelight_index
              section_perimeter = (@section_height[index].to_i * 2 + @section_width[index] * 2) / 12
              section_perimeter = option.minimum_quantity if section_perimeter < option.minimum_quantity
              perimeter += section_perimeter
            end
          when 3 # per glass
            perimeter = 0
            1.upto(shape.sections_height) do |r|
              1.upto(shape.sections_width) do |c|
                opening = Opening.find(openings[((r - 1) * shape.sections_width + c).to_s].to_i)
                glasses_quantity = (opening.glasses_quantity == 0 ? 1 : opening.glasses_quantity)
                # for now, consider all glasses of the section to be of equal perimeter
                glass_perimeter = (@real_height[r] * 2 + @real_width[c] * 2 / glasses_quantity) / 12
                glass_perimeter = option.minimum_quantity if glass_perimeter < option.minimum_quantity
                perimeter += glass_perimeter * glasses_quantity
              end
            end
            if shape.has_upper_transom?
              index = @upper_transom_index
              opening = Opening.find(openings[index].to_i)
              glasses_quantity = (opening.glasses_quantity == 0 ? 1 : opening.glasses_quantity)
              # for now, consider all glasses of the section to be of equal perimeter
              glass_perimeter = (@section_height[index].to_i * 2 + @total_width * 2 / glasses_quantity) / 12
              glass_perimeter = option.minimum_quantity if glass_perimeter < option.minimum_quantity
              perimeter += glass_perimeter * glasses_quantity
            end
            if shape.has_lower_transom?
              index = @lower_transom_index
              opening = Opening.find(openings[index].to_i)
              glasses_quantity = (opening.glasses_quantity == 0 ? 1 : opening.glasses_quantity)
              glass_perimeter = (@section_height[index].to_i * 2 + @total_width * 2 / glasses_quantity) / 12
              glass_perimeter = option.minimum_quantity if glass_perimeter < option.minimum_quantity
              perimeter += glass_perimeter * glasses_quantity
            end
            if shape.has_left_sidelight?
              index = @left_sidelight_index
              opening = Opening.find(openings[index].to_i)
              glasses_quantity = (opening.glasses_quantity == 0 ? 1 : opening.glasses_quantity)
              # for now, consider all glasses of the section to be of equal perimeter
              glass_perimeter = (@section_height[index].to_i * 2 + @section_width[index] * 2 / glasses_quantity) / 12
              glass_perimeter = option.minimum_quantity if glass_perimeter < option.minimum_quantity
              perimeter += glass_perimeter * glasses_quantity
            end
            if shape.has_right_sidelight?
              index = @right_sidelight_index
              opening = Opening.find(openings[index].to_i)
              glasses_quantity = (opening.glasses_quantity == 0 ? 1 : opening.glasses_quantity)
              glass_perimeter = (@section_height[index].to_i * 2 + @section_width[index] * 2 / glasses_quantity) / 12
              glass_perimeter = option.minimum_quantity if glass_perimeter < option.minimum_quantity
              perimeter += glass_perimeter * glasses_quantity
            end
        end
      else
        perimeter = (@total_width * 2 + @total_height * 2) / 12
      end
      option_price = option.price * perimeter
    end

    def calc_one_option_price_per_sq_ft(openings, option, shape)
      area = 0
      if option.minimum_quantity != 0
        case option.options_minimum_unit_id
          when 1 # per window
            area = (@total_width / 12) * (@total_height / 12)
            area = option.minimum_quantity if area < option.minimum_quantity
          when 2 # per section
            1.upto(shape.sections_height) do |r|
              1.upto(shape.sections_width) do |c|
                opening = Opening.find(openings[((r - 1) * shape.sections_width + c).to_s].to_i)
                area += compute_minimum_section_area( @real_height[r] * @real_width[c] / 144, option, opening)
              end
            end
            if (shape.has_upper_transom?)
              opening = Opening.find(openings[@upper_transom_index].to_i)
              area += compute_minimum_section_area(@section_height[@upper_transom_index].to_i * @total_width / 144, option, opening)
            end
            if (shape.has_lower_transom?)
              opening = Opening.find(openings[@lower_transom_index].to_i)
              area += compute_minimum_section_area(@section_height[@lower_transom_index].to_i * @total_width / 144, option, opening)
            end
            if (shape.has_left_sidelight?)
              index = @left_sidelight_index
              opening = Opening.find(openings[index].to_i)
              area += compute_minimum_section_area(@section_height[index].to_f * @section_width[index].to_f / 144.0, option, opening)
            end
            if (shape.has_right_sidelight?)
              index = @right_sidelight_index
              opening = Opening.find(openings[index].to_i)
              area += compute_minimum_section_area(@section_height[index].to_f * @section_width[index].to_f / 144.0, option, opening)
            end
          when 3 # per glass
            1.upto(shape.sections_height) do |r|
              1.upto(shape.sections_width) do |c|
                opening = Opening.find(openings[((r - 1) * shape.sections_width + c).to_s].to_i)
                # for now, consider all glasses of the section to be of equal area
                area += compute_minimum_glass_area(@real_height[r] * @real_width[c] / 144, option, opening)
              end
            end
            if (shape.has_upper_transom?)
              section_area = @section_height[@upper_transom_index].to_i * @total_width / 144
              opening = Opening.find(openings[@upper_transom_index].to_i)
              area += compute_minimum_glass_area(section_area, option, opening)
            end
            if (shape.has_lower_transom?)
              section_area = @section_height[@lower_transom_index].to_i * @total_width / 144
              opening = Opening.find(openings[@lower_transom_index].to_i)
              area += compute_minimum_glass_area(section_area, option, opening)
            end
            if (shape.has_left_sidelight?)
              index = @left_sidelight_index
              section_area = @section_height[index].to_f * @section_width[index].to_f / 144.0
              opening = Opening.find(openings[index].to_i)
              area += compute_minimum_glass_area(section_area, option, opening)
            end
            if (shape.has_right_sidelight?)
              index = @right_sidelight_index
              section_area = @section_height[index].to_f * @section_width[index].to_f / 144.0
              opening = Opening.find(openings[index].to_i)
              area += compute_minimum_glass_area(section_area, option, opening)
            end
        end
      else
        case option.apply_to
          when 2 # applies to all
            area = (@total_width / 12) * (@total_height / 12)
          when 0,1 # applies to fixed / openable openings only
            area = compute_area_for_openings(shape, openings, option.apply_to)
        end
      end
      option_price = option.price * area
    end

  def compute_area_for_openings(shape, openings, openable)
    area = 0
    1.upto(shape.sections_height) do |r|
      1.upto(shape.sections_width) do |c|
        section_area = @real_height[r] * @real_width[c] / 144.0
        opening = Opening.find(openings[((r - 1) * shape.sections_width + c).to_s].to_i)
        # for now, consider all glasses of the section to be of equal area
        area += section_area if applies_to(opening, openable)
      end
    end

    area += compute_section_area(@upper_transom_index, openable, openings, @total_width) if shape.has_upper_transom?
    area += compute_section_area(@lower_transom_index, openable, openings, @total_width) if shape.has_upper_transom?

    area += compute_section_area(left_sidelight_index(shape), openable, openings) if shape.has_left_sidelight?
    area += compute_section_area(right_sidelight_index(shape), openable, openings) if shape.has_right_sidelight?

    area
  end

  def compute_section_area(index, openable, openings, width = nil)
    width ||= @section_width[index].to_f
    section_area = @section_height[index].to_f * width / 144.0
    opening = Opening.find(openings[index].to_i)
    applies_to(opening, openable) ? section_area : 0
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


  def setup_quotation_line(ql)
    @openings = {}
    ql.quotation_lines_openings.each do |o|
      @openings[o.sort_order.to_s] = o.opening_id
    end
    @section_height = {}
    ql.section_heights.each do |h|
      @section_height[h.sort_order.to_s] = h.value
    end
    @section_width = {}
    ql.section_widths.each do |w|
      @section_width[w.sort_order.to_s] = w.value
    end
    @serie = ql.serie

    shape = Shape.find(ql.shape_id)

    @upper_transom_index = ql.upper_transom_index(shape).to_s if shape.has_upper_transom?
    @lower_transom_index = ql.lower_transom_index(shape).to_s if shape.has_lower_transom?
    @left_sidelight_index = ql.left_sidelight_index(shape).to_s if shape.has_left_sidelight?
    @right_sidelight_index = ql.right_sidelight_index(shape).to_s if shape.has_right_sidelight?

  end
  
  def calculate_dimensions(ql)
    setup_quotation_line(ql)
    width = ql.width
    height = ql.height
    shape = Shape.find(ql.shape_id)
    #total width & height INCLUDES transoms &sidelights
    @total_height = height.to_f
    @total_width = width.to_f
    adjust_total_height_for_transoms = @total_height == 0
    adjust_total_width_for_sidelights = @total_width == 0

    total_transom_height = 0
    total_transom_height += @section_height[@upper_transom_index].to_f if shape.has_upper_transom?
    total_transom_height += @section_height[@lower_transom_index].to_f if shape.has_lower_transom?
    total_sidelight_width = 0
    total_sidelight_width += @section_width[@left_sidelight_index].to_f if shape.has_left_sidelight?
    total_sidelight_width += @section_width[@right_sidelight_index].to_f if shape.has_right_sidelight?

    ## calculate all heights
    # get known heights, or 0 if missing
    @real_height = {}
    1.upto(shape.sections_height) do |l|
      @real_height[l] = @section_height[l.to_s].to_f
    end
    # count missing heights
    cpt_missing = 0
    acc_dimension = 0
    @real_height.each_value do |v|
      cpt_missing += 1 if v == 0
      acc_dimension += v
    end

    # if we have missing heights and total_height is not specified we can't continue
    if cpt_missing > 0 && @total_height == 0
      return trn_get('MSG_NOT_ENOUGH_DATA')
    end

    # complete missing heights if possible
    if cpt_missing == 0
      # no missing heights so just compute the total height if not supplied
      @total_height = acc_dimension + total_transom_height if @total_height == 0
      return trn_get('MSG_HEIGHTS_DONT_MATCH') if @total_height != acc_dimension + total_transom_height
    else
        # any height not accounted for to be spread across any openings with 0 height
        deducted = (@total_height - acc_dimension - total_transom_height) / cpt_missing
        @real_height.each do |k, v|
          @real_height[k] = deducted if v == 0
        end
    end
    # check that we have no negative dimensions
    @real_height.each_value do |v|
      return trn_get('MSG_NEGATIVE_DIMENSION') if v < 0
    end

    ## calculate all widths
    # get known widths, or 0 if missing
    @real_width = {}
    1.upto(shape.sections_width) do |l|
      @real_width[l] = @section_width[l.to_s].to_f
    end
    # count missing widths
    cpt_missing = 0
    acc_dimension = 0
    @real_width.each_value do |v|
      cpt_missing += 1 if v == 0
      acc_dimension += v
    end

    # if we have missing heights and total_height is not specified we can't continue
    if cpt_missing > 0 && @total_width == 0
      return trn_get('MSG_NOT_ENOUGH_DATA')
    end

    # complete missing widths if possible
    if cpt_missing == 0
      @total_width = acc_dimension + total_sidelight_width if @total_width == 0
      return trn_get('MSG_WIDTHS_DONT_MATCH') if @total_width != acc_dimension + total_sidelight_width
    else
        deducted = (@total_width - acc_dimension - total_sidelight_width) / cpt_missing
        @real_width.each do |k, v|
          @real_width[k] = deducted if v == 0
        end
    end
    # check that we have no negative dimensions
    @real_width.each_value do |v|
      return trn_get('MSG_NEGATIVE_DIMENSION') if v < 0
    end

    return nil
  end

  
end

