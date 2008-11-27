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

  def display_first_only(counter)
    counter.zero? ? {} : { :style => 'display:none' }
  end

  def slideshow_tag(content, options = {})
    options.reverse_merge! :size => '500x500', :style => :large
    render :partial => (content.photos.any? ? content.photos : Photo.new), :locals => { :style => options[:style], :size => options[:size], :slideshow => true }
  end
end