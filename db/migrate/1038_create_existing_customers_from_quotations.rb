class CreateExistingCustomersFromQuotations < ActiveRecord::Migration
  def self.up
    quotations = Quotation.all()
    quotations.each do |quotation| 
      Customer.create_from_quotation_if_new(quotation)
    end
  end

  def self.down
  end
end
