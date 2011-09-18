class OptionQuotationController < ApplicationController
  def add
    @options = Option.all(:order => :description)
    @quotation = Quotation.find(params[:id])
    @quantity = 1
  end

  def create
    @quotation = Quotation.find(params[:id])
    @quotation.options_quotations << OptionsQuotation.new(:option_id => params[:option_id],
                                                          :quantity => params[:quantity].to_i)
    redirect_to :controller => 'quotation', :action => 'show', :id => @quotation.id
  end

  def edit
    @options = Option.all(:order => :description)
    @option = OptionsQuotation.find(params[:id])
  end

  def update
    @option = OptionsQuotation.find(params[:id])
    @option.update_attributes :option_id => params[:option_id],
                              :quantity => params[:quantity].to_i
    redirect_to :controller => 'quotation', :action => 'show', :id => @option.quotation.id
  end

  def delete
    option = OptionsQuotation.find(params[:id])
    option.destroy
    redirect_to :controller => 'quotation', :action => 'show', :id => option.quotation.id
  end
end
