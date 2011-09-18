class Quotation < ActiveRecord::Base
  has_many :quotation_lines, :dependent => :destroy
  has_many :options_quotations, :dependent => :destroy
  belongs_to :user
  belongs_to :company  

  validates_presence_of :project_name
  validates_numericality_of :markup, :allow_nil => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 30
  validates_numericality_of :deposit, :allow_nil => true, :greater_than_or_equal_to => 0

  def use_billing_address?
    if (customer_address.nil? || delivery_address.nil?)
     return false
    end

   return customer_address == delivery_address
  end
  
  def calculate_taxes(total)
   total * self.taxes / 100
  end

  def calculate_pst(total)
    if !self.taxes_pst.blank?
      total * self.taxes_pst / 100 
    else
     0.0
    end
  end
end
