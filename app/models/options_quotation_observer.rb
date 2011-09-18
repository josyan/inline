class OptionsQuotationObserver < ActiveRecord::Observer

  def after_save(opt)
    opt.quotation.update_attribute(:updated_at, Time.now)
  end

end
