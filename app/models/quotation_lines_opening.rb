class QuotationLinesOpening < ActiveRecord::Base
  belongs_to :quotation_line
  belongs_to :opening

  validates_presence_of :opening_id, :sort_order
end
