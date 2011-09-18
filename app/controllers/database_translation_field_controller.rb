class DatabaseTranslationFieldController < ApplicationController
    before_filter :check_administrator_role
  def list
    @dbtfs = DatabaseTranslationField.all(:order => "`table`, `translation_field_name`")
  end

  def add
    @dbtf = DatabaseTranslationField.new
  end

  def create
    @dbtf = DatabaseTranslationField.new(params[:dbtf])
    if @dbtf.save
      flash[:notice] = trn_geth('LABEL_DBTF') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_M')
      redirect_to :action => 'list'
    else
      render :action => 'add'
    end
  end

  def edit
    @dbtf = DatabaseTranslationField.find(params[:id])
  end

  def update
    @dbtf = DatabaseTranslationField.find(params[:id])
    if @dbtf.update_attributes(params[:dbtf])
      flash[:notice] = trn_geth('LABEL_DBTF') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_M')
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end

  def delete
    dbtf = DatabaseTranslationField.find(params[:id])
    dbtf.destroy
    DatabaseTranslation.destroy_all.where(:table => dbtf.table, :translation_field_name => dbtf.translation_field_name)
    flash[:notice] = trn_geth('LABEL_DBTF') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_M')
    redirect_to :action => 'list'
  end
end
