 # new methods for translation
 class ActiveRecord::Base
   include Translatable
   cattr_accessor :lang
 end
