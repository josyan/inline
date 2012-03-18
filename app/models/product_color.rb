class ProductColor < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :value
  validates_format_of :color, :with => /^#?([a-f]|[A-F]|[0-9]){3}(([a-f]|[A-F]|[0-9]){3})?$/,  :message => "should be hex encoded (eg '#cccccc', like in CSS)", :allow_blank => true

  belongs_to :module_type

  def color
    if !value.blank?
      value
    else
      "#cccccc"
    end
  end

end
