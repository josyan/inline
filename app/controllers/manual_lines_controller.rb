class ManualLinesController < ApplicationController

  def new
    @manual_line = ManualLine.new(:quotation_id => params[:id], :quantity => 1, :unit_price => 0)
  end

  def create
    @manual_line = ManualLine.new(params[:manual_line])
    if @manual_line.save
      flash[:notice] = trn_geth('LABEL_MANUAL_OPTION') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_F')
      redirect_to :controller => 'quotation', :action => 'show', :id => @manual_line.quotation.slug
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

end
