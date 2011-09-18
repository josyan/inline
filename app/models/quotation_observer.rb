class QuotationObserver < ActiveRecord::Observer
  
  def after_create(quotation)
    QuotationMailer.created_notification(quotation).deliver
  end
  
end
