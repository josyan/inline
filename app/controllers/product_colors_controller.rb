class ProductColorsController < ApplicationController
  layout 'application'

  # GET /product_colors
  # GET /product_colors.xml
  def index
    @module_type = ModuleType.find(params[:mt] || 1)
    @product_colors = ProductColor.all(:conditions => { :module_type_id => @module_type.id })

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @product_colors }
    end
  end

  # GET /product_colors/1
  # GET /product_colors/1.xml
  def show
    @product_color = ProductColor.find(params[:id])
    @module_type = @product_color.module_type

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product_color }
    end
  end

  # GET /product_colors/new
  # GET /product_colors/new.xml
  def new
    @module_type = ModuleType.find(params[:mt] || 1)
    @product_color = ProductColor.new(:module_type_id => @module_type.id)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_color }
    end
  end

  # GET /product_colors/1/edit
  def edit
    @product_color = ProductColor.find(params[:id])
    @module_type = @product_color.module_type
  end

  # POST /product_colors
  # POST /product_colors.xml
  def create
    @product_color = ProductColor.new(params[:product_color])
    @module_type = @product_color.module_type

    respond_to do |format|
      if @product_color.save
        flash[:notice] = trn_get('MSGF_COLOR_CREATED')
        format.html { redirect_to(product_colors_url(:mt => @module_type.id)) }
        format.xml  { render :xml => @product_color, :status => :created, :location => @product_color }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product_color.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /product_colors/1
  # PUT /product_colors/1.xml
  def update
    @product_color = ProductColor.find(params[:id])
    @module_type = @product_color.module_type

    respond_to do |format|
      if @product_color.update_attributes(params[:product_color])
        flash[:notice] = trn_get('MSGF_COLOR_UPDATED')
        format.html { redirect_to(product_colors_url(:mt => @module_type.id)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product_color.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /product_colors/1
  # DELETE /product_colors/1.xml
  def destroy
    @product_color = ProductColor.find(params[:id])
    @product_color.destroy
    @module_type = @product_color.module_type

    respond_to do |format|
      format.html { redirect_to(product_colors_url(:mt => @module_type.id)) }
      format.xml  { head :ok }
    end
  end
end
