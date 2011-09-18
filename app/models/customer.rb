class Customer < ActiveRecord::Base

  belongs_to :user
  
  def self.create_from_quotation_if_new(quotation)
    # look for an existing customer record by name.
    # if no record found, create one.
    return false if quotation.customer_name.nil? or quotation.customer_name.blank?
    customer = find_by_name(quotation.customer_name)
    if (customer.nil?)
      customer = Customer.new
      customer.name = quotation.customer_name 
      customer.address = quotation.customer_address unless quotation.customer_address.blank?
      customer.phone = quotation.customer_phone unless quotation.customer_phone.blank?
      customer.fax = quotation.customer_fax unless quotation.customer_fax.blank?
      customer.email = quotation.customer_email unless quotation.customer_email.blank?
      customer.save
      true
    else
      false
      end
  end

end
