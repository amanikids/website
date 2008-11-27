class Page < Content
  validates_presence_of :title, :slug, :body
  validates_format_of :slug, :with => /^[a-z0-9-]+$/

  def next_page
    lower_item || (parent.lower_item.is_a?(Section) ? parent.lower_item.children.first : nil)
  end

  def show_children?
    children.any?
  end
end
