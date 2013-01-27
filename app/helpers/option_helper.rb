module OptionHelper
  def show_option(opt)
    style = "style='font-weight:bold;'" if opt.emphasize
    "<span #{style}>#{opt.tr_description}</span>".html_safe
  end
end
