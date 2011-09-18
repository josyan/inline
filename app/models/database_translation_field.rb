class DatabaseTranslationField < ActiveRecord::Base
  validates_presence_of :table, :field
end
