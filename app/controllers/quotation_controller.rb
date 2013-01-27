class QuotationController < ApplicationController

  before_filter :find_quotation, :only => [:show, :print, :print_invoice, :print_manifest, :print_calculations]
  sortable_attributes  :updated_at, :slug, :description, :created_by, :consultant

  SEARCH_FIELDS = %w(search_description search_slug)
  def index
    search_params_from_session
    conditions = {:user_id => @current_user.id} unless @current_user.has_role?('administrator')
    @quotations = Quotation.includes(:user).where(conditions).where(search_conditions).paginate(:page => params[:page], :per_page => 25).order(sort_order || "updated_at DESC")
  end

  def show
    if @quotation.user_id != @current_user.id && !@current_user.has_role?('administrator')
      flash[:notice] = trn_geth("PERMISSION_DENIED")
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
    @quotation.user_id = @current_user.id
    customer_msg = ""
    if Customer.create_from_quotation_if_new(@quotation)
      customer_msg = trn_geth('LABEL_CUSTOMER') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_F')
    end
    if @quotation.save
    	if @quotation.slug.blank?
    	  @quotation.slug = @quotation.id.to_s
    	  @quotation.save
    	end
      customer_msg += "<br />" unless customer_msg.blank?
      customer_msg +=  trn_geth('LABEL_QUOTATION') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_F')
      flash[notice] = customer_msg.html_safe
      redirect_to :action => 'show', :id => @quotation.slug
    else
      render :action => 'new'
    end
  end

  def edit
    @quotation = Quotation.find_by_slug(params[:id])
    @users = User.find_all_by_enabled(true)
  end

  def update
    set_taxes_if_not_present()

    @quotation = Quotation.find(params[:id])

    if @quotation.update_attributes(params[:quotation])
      flash[:notice] = trn_geth('LABEL_QUOTATION') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_F')
      redirect_to :action => 'show', :id => @quotation.slug
    else
      render :action => 'edit'
    end
  end

  def destroy
    Quotation.find_by_slug(params[:id]).destroy
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

  def copy
#    return unless request.xhr?
    @orig_quotation = Quotation.includes(:quotation_lines => [:serie, :shape, {:quotation_lines_openings => :opening}, {:options_quotation_lines=> :option}]).find_by_slug(params[:quotation_id])
    if @orig_quotation.user_id != @current_user.id && !@current_user.has_role?('administrator')
      flash[notice] = trn_get("PERMISSION_DENIED")
      redirect_to :action => 'index'
    end
    @quotation = Quotation.copy(@orig_quotation)
    @quotation.save!
    @quotation.regenerate_previews
    flash[:notice] = trn_geth('LABEL_QUOTATION') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_F')
    redirect_to edit_quotation_path(@quotation.slug)
  end
  def search
    save_search_params_to_session
    params[:action] = "index"

    if @current_user.has_role?('administrator')
      @quotations = Quotation.includes(:user).paginate(:page => params[:page], :order => sort_order, :conditions => search_conditions, :per_page => 25)
    else
      @quotations = Quotation.includes(:user).where("user_id = ?", @current_user.id).paginate(:page => params[:page], :order => sort_order, :conditions => search_conditions, :per_page => 25)
    end

    render :partial => 'quotation_list'
  end

protected
  def search_params_from_session
    SEARCH_FIELDS.each { |x| params[x.to_sym] = session[x.to_sym]}
  end

  def save_search_params_to_session
    SEARCH_FIELDS.each { |x| session[x.to_sym] = params[x.to_sym]}
  end

  def match_beginning(value)
    " like \'#{value}%\'"
  end

  def match_ending(value)
    " like \'%#{value}\'"
  end

  def match_anywhere(value)
    " like \'%#{value}%\'"
  end

  def match_exact(value)
    new_value = value.gsub /\*/, '%'
    " like '#{new_value}'"
  end

  def search_condition_for(field, value)
    return nil if value.blank?
    case field.gsub(/search_/, "")
      when "slug"
        "slug "+ match_anywhere(value)
      when "description"
        "customer_name" + match_anywhere(value)
    end
  end

  def search_conditions
    conditions = SEARCH_FIELDS.collect{|x| search_condition_for(x, params[x.to_sym])}
    conditions = conditions.delete_if{|x| x.nil?}
    conditions.join(" and ")
  end
  def find_quotation
    @quotation = Quotation.includes(:quotation_lines => [:serie, :shape, {:quotation_lines_openings => :opening}, {:options_quotation_lines=> :option}]).find_by_slug(params[:id])
  end

  def set_taxes_if_not_present
    params[:quotation]['taxes']     = 0.0 if params[:quotation]['taxes'].blank?
    params[:quotation]['taxes_pst'] = 0.0 if params[:quotation]['taxes_pst'].blank?
  end

end
