class PriceError < RuntimeError
end

class QuotationLineController < ApplicationController
  
  before_filter :prepare_vars, :only => {"edit", "print_calculations"}

  def add
    @quotation_line = QuotationLine.new
    @quotation_line.quotation_id = params[:id]
  end

  def add2
    @quotation_line = QuotationLine.new(params[:quotation_line])
    @quotation_line.width = 0
    @quotation_line.height = 0
    @quotation_line.quantity = 1

    initialize_by_shape()

    @openings = {}
    @serie = Serie.includes(:options => [:pricing_method, :options_minimum_unit]).find(@quotation_line.serie_id)

    # are we creating a similar window? if so, bring forward selected options
    # from the last line entered
    copy_options_from_last_line() if params[:ql_copy_options]
    
    initialize_options_for_series()
    
  end

  # ajax call to change the series for this line
  def change_series
    return unless request.xhr?
    serie_id = params[:serie_id]
    @quotation_line = QuotationLine.new(params[:quotation_line])
    @openings = {} #params[:openings]
    @section_height = params[:section_height] || {}
    @section_width = params[:section_width] || {}
    @serie = Serie.includes(:options => [:pricing_method, :options_minimum_unit]).find(serie_id)
    initialize_options_for_series()    
  end
  
  # ajax call to change the shape for this line
  def change_shape
    return unless request.xhr?
    @quotation_line = QuotationLine.new(params[:quotation_line])
    @openings = params[:openings]
    @section_height = params[:section_height] || {}
    @section_width = params[:section_width] || {}
    @serie = Serie.includes(:options => [:pricing_method, :options_minimum_unit]).find(@quotation_line.serie_id)
    initialize_options_for_series()        
  end

  def create
    @quotation_line = QuotationLine.new(params[:quotation_line])
    @openings = params[:openings]
    @serie = Serie.find(@quotation_line.serie_id)
    @options = @serie.options.sort_by { |o| o.tr_description }
    @section_height = params[:section_height] || {}
    @section_width = params[:section_width] || {}

    shape = Shape.find(@quotation_line.shape_id)
    @upper_transom_index = upper_transom_index(shape) if shape.has_upper_transom
    @lower_transom_index = lower_transom_index(shape) if shape.has_lower_transom

    error = calculate_dimensions(@quotation_line.width, @quotation_line.height)
    if error
      @quotation_line.price = 0
      flash[:notice] = error
      render :action => 'add2'
    else
      new_selected_options = get_options_from_params(params)
      begin
        @quotation_line.price = calculate_price(@quotation_line.serie_id, @quotation_line.shape_id, @openings, new_selected_options)
      rescue PriceError => err
        @quotation_line.price = 0
        flash[:notice] = err.message
        render :action => 'add2'
      end
      if @quotation_line.price != 0

        # save calculated dimensions
        @quotation_line.height = @total_height
        @quotation_line.width = @total_width
        if @quotation_line.save

          # save openings
          # TODO sort_order won't work with transoms
          @openings.each_pair do |key, value|
            @quotation_line.quotation_lines_openings.create(:opening_id => value.to_i, :sort_order => key.to_i)
          end

          # save section dimensions
          @real_height.each do |k, v|
            @quotation_line.section_heights.create(:sort_order => k, :value => v)
          end
          @real_width.each do |k, v|
            @quotation_line.section_widths.create(:sort_order => k, :value => v)
          end

          # save the transom heights
          if (shape.has_upper_transom)
            @quotation_line.section_heights.create(:sort_order => @upper_transom_index, :value => @section_height[@upper_transom_index])
            @quotation_line.section_widths.create(:sort_order => @upper_transom_index, :value => @total_width)
          end

          if (shape.has_lower_transom)
            @quotation_line.section_heights.create(:sort_order => @lower_transom_index, :value => @section_height[@lower_transom_index])
            @quotation_line.section_widths.create(:sort_order => @lower_transom_index, :value => @total_width)
          end

          # save options
          new_selected_options.each do |o|
            @quotation_line.options_quotation_lines << OptionsQuotationLine.new(:option_id => o,
                                                                                :quantity => ((qty = params["option_quantity_#{o}".to_sym]) ? qty.to_i : 1))
          end

          # create and save image
          @quotation_line.create_image(shape)

          flash[:notice] = trn_geth('LABEL_QUOTATION_LINE') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_F')
          redirect_to :controller => 'quotation', :action => 'show', :id => @quotation_line.quotation_id
        else
          render :action => 'add'
        end
      end
    end
  end

  def edit
    
    #    @quotation_line = QuotationLine.find(params[:id], :include => [:shape,  {:serie => {:options => [:pricing_method, :options_minimum_unit]}}, 
    #                                                                  {:options_quotation_lines => [:option=> [:pricing_method, :options_minimum_unit]]}])
    
    @quotation_line = QuotationLine.includes(:serie => [:options => [:pricing_method, :options_minimum_unit]], :options_quotation_lines => :option).find(params[:id])
    @openings = {}
    @quotation_line.quotation_lines_openings.each do |o|
      @openings[o.sort_order.to_s] = o.opening_id
    end
    @section_height = {}
    @quotation_line.section_heights.each do |h|
      @section_height[h.sort_order.to_s] = h.value
    end
    @section_width = {}
    @quotation_line.section_widths.each do |w|
      @section_width[w.sort_order.to_s] = w.value
    end
    @serie = @quotation_line.serie

    shape = Shape.find(@quotation_line.shape_id)
    
    @upper_transom_index = upper_transom_index(shape) if shape.has_upper_transom
    @lower_transom_index = lower_transom_index(shape) if shape.has_lower_transom


    @options = @serie.options #.sort_by {|o| o.tr_description }
    @options.each do |option|
      if option.pricing_method.quantifiable
        oli_index = @quotation_line.options_quotation_lines.index {|o| o.option_id == option.id}
        if (oli_index.nil?)
          qty = option.minimum_quantity
        else
          qty = @quotation_line.options_quotation_lines[oli_index].quantity
        end
        instance_variable_set "@option_quantity_#{option.id}".to_sym, qty
      end
    end
  end

  def update
    @quotation_line = QuotationLine.find(params[:id])
    @openings = params[:openings]
    @quotation_line.serie_id = params[:serie_id]
    @serie = Serie.find(@quotation_line.serie_id)
    @options = @serie.options.sort_by {|o| o.tr_description }
    @section_height = params[:section_height] || {}
    @section_width = params[:section_width] || {}
    shape = Shape.find(params[:shape_id])
    @quotation_line.shape = shape
    @upper_transom_index = upper_transom_index(shape) if shape.has_upper_transom
    @lower_transom_index = lower_transom_index(shape) if shape.has_lower_transom
    
    error = calculate_dimensions(params[:quotation_line][:width], params[:quotation_line][:height])
    if error
      @quotation_line.price = 0
      flash[:notice] = error
      render :action => 'edit'
    else
      
      new_selected_options = get_options_from_params(params)
      
      begin
        @quotation_line.price = calculate_price(@quotation_line.serie_id, @quotation_line.shape_id, @openings, new_selected_options)
      rescue PriceError => err
        @quotation_line.price = 0
        flash[:notice] = err.message
        render :action => 'edit'
      end
      if @quotation_line.price != 0

        # save calculated dimensions
        params[:quotation_line][:height] = @total_height
        params[:quotation_line][:width] = @total_width
        if @quotation_line.update_attributes(params[:quotation_line])

          # update openings
          @openings.each do |order, opening_id|
            opening = @quotation_line.quotation_lines_openings.select {|o| o.sort_order == order.to_i}.first
            opening ||= @quotation_line.quotation_lines_openings.build(:opening_id => opening_id.to_i, :sort_order => order.to_i)
            opening.update_attributes(:opening_id => opening_id.to_i, :sort_order => order.to_i)
          end

          #destroy any excess openings. This happens when user goes from 3 openings to 2 or 1, for example
          @quotation_line.quotation_lines_openings[@openings.length..@quotation_line.quotation_lines_openings.length].each {|opening| opening.destroy }

          # clear and save section dimensions
          @quotation_line.section_heights.clear
          @quotation_line.section_widths.clear
          @real_height.each do |k, v|
            @quotation_line.section_heights.create(:sort_order => k, :value => v)
          end
          @real_width.each do |k, v|
            @quotation_line.section_widths.create(:sort_order => k, :value => v)
          end

          # save the transom heights
          if (shape.has_upper_transom)
            @quotation_line.section_heights.create(:sort_order => @upper_transom_index, :value => @section_height[@upper_transom_index])
            @quotation_line.section_widths.create(:sort_order => @upper_transom_index, :value => @total_width)
          end

          if (shape.has_lower_transom)
            @quotation_line.section_heights.create(:sort_order => @lower_transom_index, :value => @section_height[@lower_transom_index])
            @quotation_line.section_widths.create(:sort_order => @lower_transom_index, :value => @total_width)
          end

          # update options
          old_selected_options = @quotation_line.options_quotation_lines.all.map { |o| o.option.id }
          (new_selected_options - old_selected_options).each do |o|
            @quotation_line.options_quotation_lines << OptionsQuotationLine.new(:option_id => o,
                                                                                :quantity => ((qty = params["option_quantity_#{o}".to_sym]) ? qty.to_i : 1))
          end
          (old_selected_options - new_selected_options).each do |o|
            @quotation_line.options_quotation_lines.delete @quotation_line.options_quotation_lines.first(:conditions => {:option_id => o})
          end
          # update quantities for existing options
          @quotation_line.options_quotation_lines.each do |o|
            o.update_attribute :quantity, ((qty = params["option_quantity_#{o.option.id}".to_sym]) ? qty.to_i : 1)
          end

          # create and save image
          @quotation_line.create_image(shape)

          flash[:notice] = trn_geth('LABEL_QUOTATION_LINE') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_F')
          redirect_to :controller => 'quotation', :action => 'show', :id => @quotation_line.quotation_id
        else
          render :action => 'edit'
        end
      end
    end
  end

  def delete
    quotation_line = QuotationLine.find(params[:id])
    quotation_line.destroy
    flash[:notice] = trn_geth('LABEL_QUOTATION_LINE') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_F')
    redirect_to :controller => 'quotation', :action => 'show', :id => quotation_line.quotation_id
  end

private

  def prepare_vars
    @openings = {}
    @quotation_line.quotation_lines_openings.each do |o|
      @openings[o.sort_order.to_s] = o.opening_id
    end
    calculate_dimensions(@quotation_line.width, @quotation_line.height)
  end

  def validate_height(serie, h)
    # make sure that the height is greater than or equal to the first value in the table
    # we do this by looking for an entry that is less than or equal to the real height. If nothing is found,
    # that means we're below the allowed size,
    if !serie.heights.exists?(["value <= #{h}"])
      raise PriceError, trn_get('MSG_HEIGHT_TOO_SMALL')
    end
    selected_height = serie.heights.where("value >= ?", h).order('value').first
    if !selected_height
      raise PriceError, trn_get('MSG_CANT_FIND_HEIGHT')
    end
    
    selected_height
  end

  def validate_width(serie, w)
    if !serie.widths.exists?(["value <= #{w}"])
      raise PriceError, trn_get('MSG_WIDTH_TOO_SMALL')
    end
    selected_width = serie.widths.where("value >= ?", w).order('value').first
    if !selected_width
      raise PriceError, trn_get('MSG_CANT_FIND_WIDTH')
    end

    selected_width
  end
  
  def calculate_option_prices(options_ids, openings, shape)
    price = 0
    options_ids.each do |o|
      option = Option.find(o)
      option_price = calculate_one_option_price(option, openings, shape)
      qty = ((opt_qty = params["option_quantity_#{o}".to_sym]) ? opt_qty.to_i : 1)
      price += option_price * qty
    end
  
    price  
  end
  
  def calculate_price(serie_id, shape_id, openings, options_ids)
    serie = @quotation_line.serie
    shape = Shape.find(shape_id)

    price = 0

    # calculate base price for all sections
    1.upto(shape.sections_height) do |r|
      selected_height = validate_height(serie, @real_height[r])
      1.upto(shape.sections_width) do |c|
        selected_width = validate_width(serie, @real_width[c])
        found_price = SeriePrice.where('width_id = ? and height_id = ? and opening_id = ?',
                                        selected_width.id, selected_height.id, openings[((r - 1) * shape.sections_width + c).to_s].to_i).first
        if !found_price
          debug_log "can't find price for width #{selected_width.id}, height #{selected_height.id}, opening #{openings[((r - 1) * shape.sections_width + c).to_s]}"
          raise PriceError, trn_get('MSG_CANT_FIND_PRICE')
        end
        price += found_price.price
      end
    end
    
    # for shapes that have transoms, price them here
    
    if shape.has_upper_transom
      selected_height = validate_height(serie, @section_height[upper_transom_index(shape)])
      selected_width = validate_width(serie, @total_width)
      found_price = SeriePrice.where('width_id = ? and height_id = ? and opening_id = ?',
                                      selected_width.id, selected_height.id, openings[upper_transom_index(shape)].to_i).first
      if !found_price
        debug_log "can't find price upper transom for width #{selected_width.id}, height #{selected_height.id}, opening #{openings[upper_transom_index(shape)].to_i}"
        raise PriceError, trn_get('MSG_CANT_FIND_PRICE')
      end
      price += found_price.price
    end
    
    if shape.has_lower_transom
      selected_height = validate_height(serie, @section_height[lower_transom_index(shape)])
      selected_width = validate_width(serie, @total_width)
      found_price = SeriePrice.where('width_id = ? and height_id = ? and opening_id = ?',
                                      selected_width.id, selected_height.id, openings[lower_transom_index(shape)].to_i).first
      if !found_price
        debug_log "can't find price upper transom for width #{selected_width.id}, height #{selected_height.id}, opening #{openings[lower_transom_index(shape)].to_i}"
        raise PriceError, trn_get('MSG_CANT_FIND_PRICE')
      end
      price += found_price.price
    end

    # calculate options price
    price += calculate_option_prices(options_ids, openings, shape)
  end

  def calculate_dimensions(width, height)
    @total_height = height.to_f
    @total_width = width.to_f
    adjust_total_height_for_transoms = @total_width == 0
    shape = Shape.find(@quotation_line.shape_id)

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
  
  def upper_transom_index(shape)
    @quotation_line.upper_transom_index(shape).to_s
  end

  def lower_transom_index(shape)
    @quotation_line.lower_transom_index(shape).to_s
  end
  
  def get_options_from_params(params)
    new_selected_options = params[:options] ? params[:options].map{ |o| o.to_i } : []
    # we have params[:option_category_<id>] that hold a single option id for single-select categories
    # we can take those id's and merge them into new_selected_options
    
    more_options = params.keys.grep(/options_category_[0-9]+/).map { |k| params[k]}.flatten
    new_selected_options += more_options
    # remove any options with index of -1, those are the special "None" options
    new_selected_options.reject! { |i| i.to_i == -1 }
    new_selected_options
  end

protected
  def calculate_one_option_price(option, openings, shape)
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

  def initialize_by_shape()
    @section_height = {}
    @section_width = {}
    shape = Shape.find(@quotation_line.shape_id)
    1.upto(shape.sections_height) do |s|
      @section_height[s.to_s] = 0
    end
    1.upto(shape.sections_width) do |s|
      @section_width[s.to_s] = 0
    end

    if shape.has_upper_transom
      @section_height[upper_transom_index(shape)] = 0
      @upper_transom_index = upper_transom_index(shape)
    end

    if shape.has_lower_transom
      @section_height[lower_transom_index(shape)] = 0
      @lower_transom_index = lower_transom_index(shape)
    end
  end

  def copy_options_from_last_line()
    last_line = @quotation_line.quotation.quotation_lines.last()
    if !last_line.nil?
      last_line.options_quotation_lines.each {|o|
          new_attribs = o.attributes
          new_attribs.delete("id")
          @quotation_line.options_quotation_lines.build(new_attribs)
        }
      @quotation_line.interior_color = last_line.interior_color
      @quotation_line.exterior_color = last_line.exterior_color
      @quotation_line.standard_interior_color = last_line.standard_interior_color
      @quotation_line.standard_exterior_color = last_line.standard_exterior_color
    end
  end
  
  def initialize_options_for_series()
    @options = @serie.options.sort_by { |o| o.tr_description }
    @options.each do |option|
      if option.pricing_method.quantifiable
        oli_index = @quotation_line.options_quotation_lines.index {|o| o.option_id == option.id}
        if (oli_index.nil?)
          qty = option.minimum_quantity
        else
          qty = @quotation_line.options_quotation_lines[oli_index].quantity
        end
        instance_variable_set "@option_quantity_#{option.id}".to_sym, qty
      end
    end
  end
end
