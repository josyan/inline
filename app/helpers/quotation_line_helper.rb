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
    option_price = 0
    case option.pricing_method_id
      when 1 # price per square foot
        if option.minimum_quantity != 0
          case option.options_minimum_unit_id
          when 1 # per window
            area = (@total_width / 12) * (@total_height / 12)
            area = option.minimum_quantity if area < option.minimum_quantity
          when 2 # per section
            area = 0
            1.upto(shape.sections_height) do |r|
              1.upto(shape.sections_width) do |c|
                section_area = @real_height[r] * @real_width[c] / 144
                section_area = option.minimum_quantity if section_area < option.minimum_quantity
                area += section_area
              end
            end
            if (shape.has_upper_transom)
              section_area = @section_height[upper_transom_index(shape)].to_i * @total_width / 144
              section_area = option.minimum_quantity if section_area < option.minimum_quantity
              area += section_area
            end
            if (shape.has_lower_transom)
              section_area = @section_height[lower_transom_index(shape)].to_i * @total_width / 144
              section_area = option.minimum_quantity if section_area < option.minimum_quantity
              area += section_area
            end
          when 3 # per glass
            area = 0
            1.upto(shape.sections_height) do |r|
              1.upto(shape.sections_width) do |c|
                section_area = @real_height[r] * @real_width[c] / 144
                opening = Opening.find(openings[((r - 1) * shape.sections_width + c).to_s].to_i)
                glasses_quantity = (opening.glasses_quantity == 0 ? 1 : opening.glasses_quantity)
                # for now, consider all glasses of the section to be of equal area
                glass_area = section_area / glasses_quantity
                glass_area = option.minimum_quantity if glass_area < option.minimum_quantity
                area += glass_area * glasses_quantity
              end
            end
            if (shape.has_upper_transom)
              section_area = @section_height[upper_transom_index(shape)].to_i * @total_width / 144
              opening = Opening.find(openings[upper_transom_index(shape)].to_i)
              glasses_quantity = (opening.glasses_quantity == 0 ? 1 : opening.glasses_quantity)
              glass_area = section_area / glasses_quantity
              glass_area = option.minimum_quantity if glass_area < option.minimum_quantity
              area += glass_area * glasses_quantity
            end
            if (shape.has_lower_transom)
              section_area = @section_height[lower_transom_index(shape)].to_i * @total_width / 144
              opening = Opening.find(openings[lower_transom_index(shape)].to_i)
              glasses_quantity = (opening.glasses_quantity == 0 ? 1 : opening.glasses_quantity)
              glass_area = section_area / glasses_quantity
              glass_area = option.minimum_quantity if glass_area < option.minimum_quantity
              area += glass_area * glasses_quantity
            end
          end
        else
          area = (@total_width / 12) * (@total_height / 12)
        end
        option_price = option.price * area
      when 2 # price by foot of perimeter
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
            if shape.has_upper_transom
              section_perimeter = (@section_height[upper_transom_index(shape)].to_i * 2 + @total_width * 2) / 12
              section_perimeter = option.minimum_quantity if section_perimeter < option.minimum_quantity
              perimeter += section_perimeter
            end
            if shape.has_lower_transom
              section_perimeter = (@section_height[lower_transom_index(shape)].to_i * 2 + @total_width * 2) / 12
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
            if shape.has_upper_transom
              opening = Opening.find(openings[upper_transom_index(shape)].to_i)
              glasses_quantity = (opening.glasses_quantity == 0 ? 1 : opening.glasses_quantity)
              # for now, consider all glasses of the section to be of equal perimeter
              glass_perimeter = (@section_height[upper_transom_index(shape)].to_i * 2 + @total_width * 2 / glasses_quantity) / 12
              glass_perimeter = option.minimum_quantity if glass_perimeter < option.minimum_quantity
              perimeter += glass_perimeter * glasses_quantity
            end
            if shape.has_lower_transom
              opening = Opening.find(openings[lower_transom_index(shape)].to_i)
              glasses_quantity = (opening.glasses_quantity == 0 ? 1 : opening.glasses_quantity)
              glass_perimeter = (@section_height[lower_transom_index(shape)].to_i * 2 + @total_width * 2 / glasses_quantity) / 12
              glass_perimeter = option.minimum_quantity if glass_perimeter < option.minimum_quantity
              perimeter += glass_perimeter * glasses_quantity
            end
          end
        else
          perimeter = (@total_width * 2 + @total_height * 2) / 12
        end
        option_price = option.price * perimeter
      when 3 # price per section
        option_price = option.price * openings.length
      when 4 # price per opening section
        nb_sections = 0
        openings.each_value { |v| nb_sections += 1 if Opening.find(v.to_i).openable }
        option_price = option.price * nb_sections
      when 5 # price by fixed section
        nb_sections = 0
        openings.each_value { |v| nb_sections += 1 if !Opening.find(v.to_i).openable }
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

    @upper_transom_index = upper_transom_index(shape) if shape.has_upper_transom
    @lower_transom_index = lower_transom_index(shape) if shape.has_lower_transom

  end
  
  def calculate_dimensions(ql)
    setup_quotation_line(ql)
    width = ql.width
    height = ql.height
    shape = Shape.find(ql.shape_id)
    @total_height = height.to_f
    @total_width = width.to_f
    adjust_total_height_for_transoms = @total_width == 0

    total_transom_height = 0
    total_transom_height += @section_height[@upper_transom_index].to_f if shape.has_upper_transom
    total_transom_height += @section_height[@lower_transom_index].to_f if shape.has_lower_transom

    ## calculate all heights
    # get known heights, or 0 if missing
    @real_height = {}
    1.upto(shape.sections_height) do |l|
      @real_height[l] = @section_height[l.to_s].to_f
    end
    # count missing heights
    cpt_missing = 0
    acc_dimension = 0
    @real_height.each do |k, v|
      cpt_missing += 1 if v == 0
      acc_dimension += v
    end
    # complete missing heights if possible
    if cpt_missing == 0
      @total_height = acc_dimension + total_transom_height if @total_height == 0
    else
      if @total_height == 0
        return trn_get('MSG_NOT_ENOUGH_DATA')
      else
        deducted = (@total_height - (acc_dimension + total_transom_height)) / cpt_missing
        @real_height.each do |k, v|
          @real_height[k] = deducted if v == 0
        end
      end
    end
    # check that we have no negative dimensions
    @real_height.each_value do |v|
      return trn_get('MSG_NEGATIVE_DIMENSION') if v < 0
    end

    #increase total_height for each transom
    if (adjust_total_height_for_transoms)
      @total_height += @section_height[@upper_transom_index].to_f if shape.has_upper_transom
      @total_height += @section_height[@lower_transom_index].to_f if shape.has_lower_transom
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
    @real_width.each do |k, v|
      cpt_missing += 1 if v == 0
      acc_dimension += v
    end
    # complete missing widths if possible
    if cpt_missing == 0
      @total_width = acc_dimension if @total_width == 0
    else
      if @total_width == 0
        return trn_get('MSG_NOT_ENOUGH_DATA')
      else
        deducted = (@total_width - acc_dimension) / cpt_missing
        @real_width.each do |k, v|
          @real_width[k] = deducted if v == 0
        end
      end
    end
    # check that we have no negative dimensions
    @real_width.each_value do |v|
      return trn_get('MSG_NEGATIVE_DIMENSION') if v < 0
    end
    return nil
  end

  
end

