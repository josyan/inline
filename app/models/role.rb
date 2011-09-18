class Role < ActiveRecord::Base
  has_many :permissions
  has_many :users, :through => :permissions
  has_many :super_users, :through => :permissions, :source => :user, :class_name => 'User', :order => 'id DESC', :conditions => "rolename='administrator'"

end
