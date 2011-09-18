class OptionsQuotation < ActiveRecord::Base
  belongs_to :option
  belongs_to :quotation
end
