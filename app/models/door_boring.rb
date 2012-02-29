class DoorBoring < ActiveRecord::Base
  include Translatable
  include Priceable

  has_attached_file :photo,
                    :url => "/system/:class/:attachment/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/system/:class/:attachment/:id/:style_:basename.:extension",
                    :default_url => "/images/:class/missing_:style.png",
                    :default_style => :original,
                    :whiny_thumbnails => true,
                    :styles => {
                       :thumb => "32x32#",
                       :normal  => "100x100>",
                       :original => "300x300"
                    }

  validates_attachment_size :photo, :less_than => 1.megabyte
end
