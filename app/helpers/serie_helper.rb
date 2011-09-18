module SerieHelper
  def humanize_series_type(series_type)
    case series_type
    when "StandardProduct"
      humanized_type = trn_get('SERIES_STANDARD_OPT')
    when "Serie"
      humanized_type = trn_get('SERIES_CUSTOM_OPT')
    when "SheetProduct"
      humanized_type = trn_get('SERIES_PERSQFT_OPT')
    end
    humanized_type.nil? ? trn_get('SERIES_CUSTOM_OPT') : humanized_type
  end
end
