class ProductColorsController < ApplicationController
  layout 'application'
  # GET /product_colors
  # GET /product_colors.xml
  def index
    @product_colors = ProductColor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @product_colors }
    end
  end

  # GET /product_colors/1
  # GET /product_colors/1.xml
  def show
    @product_color = ProductColor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product_color }
    end
  end

  # GET /product_colors/new
  # GET /product_colors/new.xml
  def new
    @product_color = ProductColor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_color }
    end
  end

  # GET /product_colors/1/edit
  def edit
    @product_color = ProductColor.find(params[:id])
  end

  # POST /product_colors
  # POST /product_colors.xml
  def create
    @product_color = ProductColor.new(params[:product_color])

    respond_to do |format|
      if @product_color.save
        flash[:notice] = trn_get('MSGF_COLOR_CREATED')
        format.html { redirect_to(:product_colors) }
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

    respond_to do |format|
      if @product_color.update_attributes(params[:product_color])
        flash[:notice] = trn_get('MSGF_COLOR_UPDATED')
        format.html { redirect_to(:product_colors) }
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

    respond_to do |format|
      format.html { redirect_to(product_colors_url) }
      format.xml  { head :ok }
    end
  end
end
