class CompanyController < ApplicationController
  before_filter :check_administrator_role

  def list
    @companies = Company.all(:order => 'name')
  end

  def show
    @company = Company.find(params[:id])
  end

  def add
    @company = Company.new
  end

  def create
    @company = Company.new(params[:company])
    if @company.save
      flash[:notice] = trn_geth('LABEL_COMPANY') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_F')
      redirect_to :action => 'show', :id => @company
    else
      render :action => 'add'
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      flash[:notice] = trn_geth('LABEL_COMPANY') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_F')
      redirect_to :action => 'show', :id => @company
    else
      render :action => 'edit'
    end
  end

  def add_users
    @company = Company.find(params[:id])
    @all_users = User.all
  end

  def update_users
    @company = Company.find(params[:id])
    @company.users.delete_all
    @company.user_ids = params[:user_ids]
    @company.save
    flash[:notice] = trn_geth('LABEL_COMPANY') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_F')
    redirect_to :action => 'show', :id => @company
  end

  def delete
    Company.find(params[:id]).destroy
    flash[:notice] = trn_geth('LABEL_COMPANY') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_F')
    redirect_to :action => 'list'
  end
end
