class QuotationController < ApplicationController

  before_filter :find_quotation, :only => [:print, :print_invoice, :print_manifest, :print_calculations]
  
  def index
    if @current_user.has_role?('administrator')
      @quotations = Quotation.all(:order => 'updated_at DESC, id DESC', :include => :user)
    else
      @quotations = Quotation.all(:order => "updated_at DESC, id DESC", :include => :user, :conditions => ["user_id = ?", @current_user.id])
    end
  end

  def show
    @quotation = Quotation.find(params[:id], :include => [{:quotation_lines => [:serie, :shape, {:quotation_lines_openings=> [:opening]}, {:options_quotation_lines=> [:option]}]}])
    if @quotation.user_id != @current_user.id && !@current_user.has_role?('administrator')
      flash[:notice] = "Permission denied"
      redirect_to :action => 'index'
    end
  end

  def new
    @quotation = Quotation.new
    @quotation.discount = @current_user.discount
    @users = User.find_all_by_enabled(true)
  end

  def create
    set_taxes_if_not_present()

    @quotation = Quotation.new(params[:quotation])
    #@quotation.taxes ||= 0.0
    #@quotation.taxes_pst || 0.0
    @quotation.user_id = @current_user.id
    customer_msg = ""
    if Customer.create_from_quotation_if_new(@quotation)
      customer_msg = trn_geth('LABEL_CUSTOMER') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_F')
    end
    if @quotation.save
      customer_msg += "<br />" unless customer_msg.blank?
      customer_msg +=  trn_geth('LABEL_QUOTATION') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_F')
      flash[:notice] = customer_msg
      redirect_to :action => 'show', :id => @quotation
    else
      render :action => 'add'
    end
  end

  def edit
    @quotation = Quotation.find(params[:id])
    @users = User.find_all_by_enabled(true)  
  end

  def update
    set_taxes_if_not_present()

    @quotation = Quotation.find(params[:id])

    if @quotation.update_attributes(params[:quotation])
      flash[:notice] = trn_geth('LABEL_QUOTATION') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_F')
      redirect_to :action => 'show', :id => @quotation
    else
      render :action => 'edit'
    end
  end

  def destroy
    Quotation.find(params[:id]).destroy
    flash[:notice] = trn_geth('LABEL_QUOTATION') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_F')
    redirect_to :action => 'index'
  end

  def print
    render :layout => 'printer'
  end

  def print_invoice
    render :layout => 'printer'
  end

  def print_manifest
    render :layout => 'printer'
  end

  def print_calculations
    if current_user.has_role?('administrator')
      render :layout => 'printer' 
    else
      redirect_to :action => 'index' 
    end
  end

protected
  def find_quotation
    @quotation = Quotation.find(params[:id], :include => [{:quotation_lines => [:serie, :shape, {:quotation_lines_openings=> [:opening]}, {:options_quotation_lines=> [:option]}]}])  
  end

  def set_taxes_if_not_present
    params[:quotation]['taxes']     = 0.0 if params[:quotation]['taxes'].blank?
    params[:quotation]['taxes_pst'] = 0.0 if params[:quotation]['taxes_pst'].blank?
  end

end
