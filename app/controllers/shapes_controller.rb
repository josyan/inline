class ShapesController < ApplicationController
  # GET /shapes
  # GET /shapes.xml
  def index
    @shapes = Shape.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shapes }
    end
  end

  # GET /shapes/1
  # GET /shapes/1.xml
  def show
    @shape = Shape.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shape }
    end
  end

  # GET /shapes/new
  # GET /shapes/new.xml
  def new
    @shape = Shape.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shape }
    end
  end

  # GET /shapes/1/edit
  def edit
    @shape = Shape.find(params[:id])
  end

  # POST /shapes
  # POST /shapes.xml
  def create
    @shape = Shape.new(params[:shape])

    respond_to do |format|
      if @shape.save
        flash[:notice] = trn_geth('LABEL_SHAPE') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_F')
        format.html { redirect_to(@shape) }
        format.xml  { render :xml => @shape, :status => :created, :location => @shape }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @shape.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /shapes/1
  # PUT /shapes/1.xml
  def update
    @shape = Shape.find(params[:id])

    respond_to do |format|
      if @shape.update_attributes(params[:shape])
        flash[:notice] = trn_geth('LABEL_SHAPE') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_F')
        format.html { redirect_to(@shape) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shape.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shapes/1
  # DELETE /shapes/1.xml
  def destroy
    @shape = Shape.find(params[:id])
    @shape.destroy
    flash[:notice] = trn_geth('LABEL_SHAPE') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_F')
    respond_to do |format|
      format.html { redirect_to(shapes_url) }
      format.xml  { head :ok }
    end
  end
end
