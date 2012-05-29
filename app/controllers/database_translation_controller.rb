class DatabaseTranslationController < ApplicationController
  before_filter :check_administrator_role
  def list
    @dbtfs = DatabaseTranslationField.order("`table`, `translation_field_name`")
    if params[:dbtf] ||= session[:dbtf]
      session[:dbtf] = (params[:dbtf] ||= session[:dbtf])
      @dbtf = DatabaseTranslationField.find(params[:dbtf] ||= session[:dbtf])
      @dbts = DatabaseTranslation.where(:table => @dbtf.table).where(:translation_field_name => @dbtf.translation_field_name)
    end
  end

  def generate
    @log = []
    DatabaseTranslationField.all.each { |dbtf|
      new_items = 0
      old_items = 0
      new_ids = dbtf.table.singularize.camelize.constantize.all.collect(&:id)
      old_ids = DatabaseTranslation.where(:table => dbtf.table).where(:translation_field_name => dbtf.translation_field_name).collect{ |r| r.record_id}
      (new_ids - old_ids).each { |id|
        DatabaseTranslation.create :record_id => id,
                                   :table => dbtf.table,
                                   :translation_field_name => dbtf.translation_field_name
        new_items += 1
      }
      ids_to_destroy = (old_ids - new_ids)
      old_items  = ids_to_destroy.length
      DatabaseTranslation.where(:record_id => ids_to_destroy).where(:table=> dbtf.table).where(:translation_field_name => dbtf.translation_field_name).destroy_all

      @log << new_items.to_s + " " + dbtf.table + " / " + dbtf.translation_field_name + " " + trn_get('LABEL_CREATED') + "." if new_items > 0
      @log << old_items.to_s + " " + dbtf.table + " / " + dbtf.translation_field_name + " " + trn_get('LABEL_DELETED') + "." if old_items > 0
    }
    list
    render :action => 'list'
  end

  def edit
    @dbt = DatabaseTranslation.find(params[:id])
  end

  def update
    @dbt = DatabaseTranslation.find(params[:id])
    if @dbt.update_attributes(params[:dbt])
      flash[:notice] = trn_geth('LABEL_TRANSLATION') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_F')
      redirect_to :action => 'list'

    else
      render :action => 'edit'
    end
  end
end
