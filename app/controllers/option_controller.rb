class OptionController < ApplicationController
    before_filter :check_administrator_role

  def list
    @options = Option.all(:order => 'description', :include => [:pricing_method, :options_minimum_unit])
  end

  def show
    @option = Option.find(params[:id])
  end

  def add
    @option = Option.new
    @all_option_categories = OptionCategory.all(:order => :display_order)
  end

  def create
    @option = Option.new(params[:option])
    if @option.save
      flash[:notice] = trn_geth('LABEL_OPTION') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_F')
      redirect_to :action => 'show', :id => @option
    else
      @all_option_categories = OptionCategory.all(:order => :display_order)
      render :action => 'add'
    end
  end

  def edit
    @option = Option.find(params[:id])
    @all_option_categories = OptionCategory.all(:order => :display_order)
  end

  def update
    @option = Option.find(params[:id])
    params[:option][:apply_to] = "2" if (params[:option][:pricing_method_id] != '1')

    if @option.update_attributes(params[:option])
      flash[:notice] = trn_geth('LABEL_OPTION') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_F')
      redirect_to :action => 'show', :id => @option
    else
      @all_option_categories = OptionCategory.all(:order => :display_order)
      render :action => 'edit'
    end
  end

  def delete
    Option.find(params[:id]).destroy
    flash[:notice] = trn_geth('LABEL_OPTION') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_F')
    redirect_to :action => 'list'
  end
end
