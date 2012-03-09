class DatabaseTranslationField < ActiveRecord::Base
  validates_presence_of :table, :translation_field_name
end
