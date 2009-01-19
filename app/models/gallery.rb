class Gallery < Content
  validates_presence_of :title, :slug, :body
  validates_format_of :slug, :with => /^[a-z0-9-]+$/

  def sort_children_by_position?
    false
  end

  def sorted_children
    children.sorted_by_title
  end
end