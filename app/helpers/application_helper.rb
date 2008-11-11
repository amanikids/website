module ApplicationHelper
  def breadcrumbs(current)
    parents = []

    while current.parent
      parents.unshift(current.parent)
      current = current.parent
    end

    parents.map! do |parent|
      if parent === Section
        parent.title
      else
        link_to parent.title, page_path(parent.slug)
      end
    end

    parents.join(': ') + ':'
  end
end