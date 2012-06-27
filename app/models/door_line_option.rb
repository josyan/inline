class DoorLineOption < ActiveRecord::Base
  belongs_to :door_line
  belongs_to :option

  def price
    p = 0

    factor = case option.pricing_method_id
             when 1 # prix au pied carré
               door_line.total_height * door_line.total_width / 144
             when 2 # prix au pied de périmètre
               (door_line.total_height + door_line.total_width) * 2 / 12
             when 3 # prix par section
               door_line.door_line_sections.length
             when 4 # prix par section ouvrante
               door_line.door_line_sections.select { |s| s.door_section.openable? }.length
             when 5 # prix par section fixe
               door_line.door_line_sections.select { |s| !s.door_section.openable? }.length
             when 6 # prix unitaire
               1
             when 7 # prix par coin
               4 # for now at least
             when 8 # prix par largeur totale
               door_line.total_width
             end
    p += option.price * factor

    if option.pricing_method.quantifiable
      p *= quantity
    end

    p
  end

end
