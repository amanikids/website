class Blog < Content
  validates_presence_of :title, :slug
  validates_format_of :slug, :with => /^[a-z0-9-]+$/

  def navigation_children
    []
  end

  def sort_children_by_position?
    false
  end

  def sorted_children
    children.sorted_by_date
  end
end
