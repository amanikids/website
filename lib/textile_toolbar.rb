module TextileToolbar
  def textile_area(object_name, method, options={})
    disable = options.delete(:disable) || {}
    toolbar = textile_toolbar(options[:id] || "#{object_name}_#{method}", disable)
    "<div class=\"textile_toolbar\">#{toolbar}</div>" <<
    "<div class=\"textile_area\">#{text_area(object_name, method, options)}</div>"
  end

  def textile_toolbar(id, disable)
    html = javascript_include_tag("textile_toolbar")
    html << link_to_function(image_tag("textile_toolbar/bold.png", :size => "23x22", :alt => "Make selection bold"), "surround_selection('#{id}', '*', '*')")
    html << "&nbsp;".html_safe
    html << link_to_function(image_tag("textile_toolbar/italic.png", :size => "23x22", :alt => "Make selection italic"), "surround_selection('#{id}', '_', '_')")
    html << "&nbsp;".html_safe
    html << link_to_function(image_tag("textile_toolbar/underline.png", :size => "23x22", :alt => "Make selection underlined"), "surround_selection('#{id}', '+', '+')")
    html << "&nbsp;".html_safe
    html << link_to_function(image_tag("textile_toolbar/hyperlink.png", :size => "23x22", :alt => "Make hyperlink"), "insert_hyperlink('#{id}')")
    html << "&nbsp;".html_safe
    unless disable == :image
      html << link_to_function(image_tag("textile_toolbar/image.png", :size => "23x22", :alt => "Insert image"), "insert_image('#{id}')")
      html << "&nbsp;&nbsp;".html_safe
    end
    html << "<small>".html_safe << link_to("Textile", "http://hobix.com/textile/", :target => "_blank") << "&nbsp;enabled</small>".html_safe
  end

  module FormBuilder
    def textile_area(method, options={})
      @template.textile_area(@object_name, method, options)
    end
  end
end
