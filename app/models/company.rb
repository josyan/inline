class Company < ActiveRecord::Base

  validates_presence_of :name
  has_and_belongs_to_many :users
#  has_and_belongs_to_many :quotations


  has_attached_file :logo,  
          :url => "/system/:class/:attachment/:id/:style_:basename.:extension",
          :path => ":rails_root/public/system/:class/:attachment/:id/:style_:basename.:extension",
          :default_url => "/images/:class/missing_:style.png",
          :default_style => :original,     :whiny_thumbnails => true,
          :styles => {
             :thumb => "32x32#",
             :normal  => "200x200>" }

  validates_attachment_size :logo, :less_than => 1.megabyte
  
end
