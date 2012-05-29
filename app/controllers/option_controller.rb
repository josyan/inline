class OptionController < ApplicationController
    before_filter :check_administrator_role

  def list
    @module_type = ModuleType.find(params[:mt] || 1)
    @options = Option.all(:order => 'description', :include => [:pricing_method, :options_minimum_unit], :conditions => { :module_type_id => @module_type.id })
  end

  def show
    @option = Option.find(params[:id])
    @module_type = @option.module_type
  end

  def add
    @module_type = ModuleType.find(params[:mt] || 1)
    @option = Option.new(:module_type_id => @module_type.id)
    @all_option_categories = OptionCategory.all(:order => :display_order)
  end

  def create
    @option = Option.new(params[:option])
    if @option.save
      flash[:notice] = trn_geth('LABEL_OPTION') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_F')
      redirect_to :action => 'show', :id => @option
    else
      @module_type = @option.module_type
      @all_option_categories = OptionCategory.all(:order => :display_order)
      render :action => 'add'
    end
  end

  def edit
    @option = Option.find(params[:id])
    @module_type = @option.module_type
    @all_option_categories = OptionCategory.all(:order => :display_order)
  end

  def update
    @option = Option.find(params[:id])
    params[:option][:apply_to] = "2" if (params[:option][:pricing_method_id] != '1')

    if @option.update_attributes(params[:option])
      flash[:notice] = trn_geth('LABEL_OPTION') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_F')
      redirect_to :action => 'show', :id => @option
    else
      @module_type = @option.module_type
      @all_option_categories = OptionCategory.all(:order => :display_order)
      render :action => 'edit'
    end
  end

  def delete
    @option = Option.find(params[:id])
    @module_type = @option.module_type
    @option.destroy
    flash[:notice] = trn_geth('LABEL_OPTION') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_F')
    redirect_to :action => 'list', :mt => @module_type.id
  end
end
