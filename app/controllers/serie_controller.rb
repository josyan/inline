class SerieController < ApplicationController
    before_filter :check_administrator_role
    
  def list
    @series = Serie.order("name")
  end

  def show
    @serie = Serie.find(params[:id])
    @categorized_options = Serie.categorize_options(@serie.options)
  end

  def add
    @serie = Serie.new
    @series = Serie.order("name")
  end

  def create
    must_import_prices = false
    orig_series = nil
    @serie = Serie.new(params[:serie])
    unless params[:source_series].blank?
      must_import_prices = true
      # cloning a series....
      orig_series = Serie.find(params[:source_series])
      @serie.series_type = orig_series.series_type
      # clone widths
      @serie.widths << orig_series.widths.map { |w| w.clone }
      # clone heights
      @serie.heights << orig_series.heights.map { |h| h.clone }
      # copy openings
      @serie.openings = orig_series.openings
      # copy options
      @serie.options = orig_series.options
    end

    if @serie.save
      flash[:notice] = trn_geth('LABEL_SERIE') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_F')
      if must_import_prices && orig_series
        @serie.openings.each do |opening|
          # copy prices
          copy_prices_from_series_and_opening(orig_series, opening, opening)
        end
      end
      redirect_to :action => 'list'
    else
      render :action => 'add'
    end
  end

  def edit
    @serie = Serie.find(params[:id])
  end

  def update
    @serie = Serie.find(params[:id])
    if @serie.update_attributes(params[:serie])
      flash[:notice] = trn_geth('LABEL_SERIE') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_F')
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end

  # given a minimum and maximum widths and heigts, and price per sq ft
  # create all sizes and set prices -- note, to do prices we need an opening id
  def generate_sizes
    @serie = Serie.find(params[:id])

    min_w = params[:series][:minimum_width].to_f
    min_h = params[:series][:minimum_height].to_f
    max_w = params[:series][:maximum_width].to_f
    max_h = params[:series][:maximum_height].to_f

    # should probably delete all existing dimensions and sizes first...

    Dimension.delete_all.where(:serie_id => @serie.id)
    
    # TODO: need to make sure starting value is even
    # next, generate all the widths and heights
    curr_width = min_w
    while curr_width <= max_w do
      Width.create :serie_id => params[:id], :value => curr_width
      curr_width += 2;
    end
    
    curr_height = min_h;
    while curr_height <= max_h do
      Height.create :serie_id => params[:id], :value => curr_height
      curr_height += 2;
    end    

    # given all the above params, generate w,h dimension every 2 inches and set price.
    redirect_to :action => 'show', :id => params[:id]
  end
  
  def generate_prices
    # given a series id, opening id, and price, fill in the prices
    @serie = Serie.find(params[:id])
    @opening = Opening.find(params[:opening_id])
    price_per_sq_ft = params[:price].to_f

    widths = Width.find_all_by_serie_id(@serie)
    heights = Height.find_all_by_serie_id(@serie)

    widths.each { |w|
      heights.each { |h|
         SeriePrice.where(:opening_id => @opening.id, :width_id => w.id, :height_id => h.id).delete_all
         value = w.value.to_f * h.value.to_f * price_per_sq_ft / 144.0
         value = value.ceil
         SeriePrice.create :width_id => w.id, :height_id => h.id, :opening_id => @opening.id, :price => value
        } 
    }
    flash[:notice] = trn_get('MSG_PRICES_GENERATED')

    redirect_to :action => 'edit_prices', :id => @serie, :opening_id => @opening.id
  end

  def delete
    Serie.find(params[:id]).destroy
    flash[:notice] = trn_geth('LABEL_SERIE') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_F')
    redirect_to :action => 'list'
  end

  def edit_prices
    @serie = Serie.find(params[:id])
    @opening = Opening.find(params[:opening_id])
  end

  def update_prices
    params.each_pair { |key, value|
      if key =~ /^price_/
        ids = key.split('_')
        if ids.length == 2 # existing price
          if value.to_f == 0 # must delete existing price
            SeriePrice.find(ids[1].to_i).destroy
          else # must update existing price
            SeriePrice.find(ids[1].to_i).update_attribute :price, value.to_f
          end
        else # new price
          if value.to_f != 0 # doesn't need to create 0 prices
            SeriePrice.create :width_id => ids[1], :height_id => ids[2], :opening_id => params[:opening_id].to_i, :price => value.to_f
          end
        end
      end
    }
    
    redirect_to :action => 'show', :id => params[:id]
  end

  def edit_options
    @serie = Serie.find(params[:id])
    @options = Option.includes(:option_categories).order('option_categories.display_order asc, options.description asc')
    # take the list of options, and rearrange it to be organized by category.
    # lets do this with a hash of hashes
    @categorized_options = Serie.categorize_options(@options)
  end

  def update_options
    @serie = Serie.find(params[:id])
    new_selected_options = params[:options] ? params[:options].map(&:to_i) : []
    old_selected_options = @serie.options.collect(&:id)
    @serie.options.concat(Option.find((new_selected_options - old_selected_options)))
#    (new_selected_options - old_selected_options).each { |o|
#      @serie.options << Option.find(o)
#    }
    (old_selected_options - new_selected_options).each { |o|
      @serie.options.delete Option.find(o)
    }
    redirect_to :action => 'show', :id => @serie
  end

  def import_prices_selection
    @serie = Serie.find(params[:id])
    @opening = Opening.find(params[:opening_id])
    @series = Serie.all(:order => 'name')
    @openings = Opening.all(:order => 'name')
  end

  def import_prices
    @serie = Serie.find(params[:id])
    @opening = Opening.find(params[:opening_id])
    unless params[:selected_serie_id] and params[:selected_opening_id]
      flash[:notice] = trn_get('MSG_STRANGE_ERROR')
      redirect_to :action => 'edit_prices', :id => @serie, :opening_id => @opening.id
      return
    end
    @org_serie = Serie.find(params[:selected_serie_id])
    @org_opening = Opening.find(params[:selected_opening_id])

    cpt = copy_prices_from_series_and_opening(@org_serie, @org_opening, @opening)

    flash[:notice] = trn_get('MSG_CPT_PRICES_IMPORTED').sub('#cpt#', cpt.to_s)
    redirect_to :action => 'edit_prices', :id => @serie, :opening_id => @opening.id
  end


    def edit_openings
    @serie = Serie.find(params[:id])
    @openings = Opening.all(:order => 'name')
  end

  def update_openings
    @serie = Serie.find(params[:id])
    new_selected_openings = params[:openings] ? params[:openings].map{ |o| o.to_i } : []
    old_selected_openings = @serie.openings.map{ |o| o.id }
    @serie.openings.concat(Opening.find(new_selected_openings - old_selected_openings))
#    (new_selected_openings - old_selected_openings).each { |o|
#      @serie.openings << Opening.find(o)
#    }
    (old_selected_openings - new_selected_openings).each { |o|
      @serie.openings.delete Opening.find(o)
    }
    redirect_to :action => 'show', :id => @serie
  end

private
    def copy_prices_from_series_and_opening(orig_serie, orig_opening, opening)
      cpt = 0
      # loop on widths and heights form source serie
      orig_serie.widths.each { |ow|
        orig_serie.heights.each { |oh|
          # get the source price
          op = SeriePrice.where('width_id = ? and height_id = ? and opening_id = ?', ow.id, oh.id, orig_opening.id).first
          if op # if no price for this width and height, nothing to do
                # get destination width and height with same values than the source width and height
            dw = @serie.widths.where('value = ?', ow.value).first
            dh = @serie.heights.where('value = ?', oh.value).first
            # if the destination serie has same dimensions
            if dw and dh
              # get destination price
              dp = SeriePrice.where('width_id = ? and height_id = ? and opening_id = ?', dw.id, dh.id, opening.id).first
              if dp # update existing price
                dp.update_attribute :price, op.price
              else # create new price
                SeriePrice.create :width_id => dw.id, :height_id => dh.id, :opening_id => opening.id, :price => op.price
              end
              cpt += 1
            end
          end
        }
      }
      cpt
    end

end
