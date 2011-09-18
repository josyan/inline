class PricingMethod < ActiveRecord::Base
  include Translatable

  has_many :options
end
