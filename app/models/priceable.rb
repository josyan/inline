module Priceable

  def self.included(base)
    base.before_save :ensure_price
  end

  private ####################################################################

  def ensure_price
    self.price ||= 0
  end

end