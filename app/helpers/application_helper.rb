module ApplicationHelper
  def breadcrumbs(current)
    parents = []

    current = current.parent
    while current.parent
      parents.unshift(current)
      current = current.parent
    end

    parents.map! do |parent|
      link_to_if parent.path, parent.title, parent.path
    end

    parents.join(': ') + ':'
  end
end