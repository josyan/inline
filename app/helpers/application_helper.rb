# Methods added to this helper will be available to all templates in the application.
include TranslationGet
module ApplicationHelper

  def yes_or_no(b)
    trn_get(b ? 'MSG_YES' : 'MSG_NO')
  end

  def ajax_spinner_for(id, spinner="spinner.gif")
     "<img src='/images/#{spinner}' style='display:none; vertical-align:middle;' id='#{id.to_s}_spinner'> ".html_safe
   end

  def gv_humanize_time(t)
    t.strftime("%a %b %d, %Y") if !t.nil?
  end


  def option_value_selected?(value, selected)
    if selected.respond_to?(:include?) && !selected.is_a?(String)
      selected.include? value
    else
      value == selected
    end
  end

  def option_text_and_value(option)
    # Options are [text, value] pairs or strings used for both.
    if !option.is_a?(String) and option.respond_to?(:first) and option.respond_to?(:last)
      [option.first, option.last]
    else
      [option, option]
    end
  end

  def options_for_select_with_style( container, selected=nil )
    container = container.to_a if Hash === container
    options_for_select = container.inject([]) do |options, element|
      text, value = option_text_and_value(element)
      selected_attribute = ' selected="selected"' if option_value_selected?(value, selected)
      style = " style=\"#{element[1]}\"" if element[1] && element[1]!=value
      options << %(<option value="#{html_escape(value.to_s)}"#{selected_attribute}#{style}>#{html_escape(text.to_s)}</option>)
    end
    options_for_select.join("\n").html_safe
  end

  def color_picker(name, colors, id, sel)
    arr = []
    on_change_function = "onChange=\";document.getElementById('#{id}').value = '';\""
    10.times { arr << "&nbsp;" }

    id_of_selected_color = sel.id unless sel.nil?

    html = ''
    html << "<select name=#{name} id=#{name} #{on_change_function}>"
    html << "<option value='' colorname='' #{'selected' if sel.nil?}>#{trn_get('MSG_SELECT_ONE')}</option>"
    html << colors.collect { |c|
      "<option value='#{c.id}' colorname='#{c.tr_name}' #{'selected' if c.id == id_of_selected_color} style='background-color: #{c.value}'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #{c.tr_name}</option>" }.join("\n")
    html << "</select>"
    html.html_safe
  end

  def css_button_to(object_name, options, html_options = {})
    html_options.merge!({:class => "css_button"})
    "<div class=\"css_button\">
      #{link_to object_name,  options, html_options}
    </div>".html_safe
  end

  def menu_item(image, link_label, link, options = {})
    display_label = trn_geth(link_label)
    display_label += ' - ' + options[:label] if options[:label]
    "<a href=#{url_for link}>#{image_tag(image + '.png', :size => "32x32", :border => 0)}<label>#{display_label}</label></a>".html_safe
  end
end
