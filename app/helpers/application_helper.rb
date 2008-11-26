module ApplicationHelper
  def breadcrumbs(page)
    parents = []

    parent = page.parent
    until parent.is_a?(Home)
      parents.unshift(parent)
      parent = parent.parent
    end

    parents.map! do |parent|
      link_to_if(parent.path, parent.title, parent.path) + ':'
    end

    parents.join(' ')
  end

  # FIXME should work with sizes other than the default (see _gallery.html.haml)
  def slideshow_tag(content, options = {})
    options.reverse_merge! :size => '500x500', :style => :large

    case content.photos.count
    when 0
    when 1
      image_tag content.photo.url(options[:style]), :size => options[:size]
    else
      render :partial => 'photos/slideshow', :locals => { :photos => content.photos, :style => options[:style], :size => options[:size] }
    end
  end
end