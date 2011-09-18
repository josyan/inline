class Height < Dimension
  has_many :serie_prices, :dependent => :destroy
end
