class Page < Content
  validates_presence_of :title, :slug, :body
  validates_format_of :slug, :with => /^[a-z0-9-]+$/

  def next_page
    lower_item || (parent.lower_item.is_a?(Section) ? parent.lower_item.children.positioned.first : nil)
  end

  def show_children_as?(style)
    (show_child_links_as == style.to_s) && children.any?
  end

  def show_children_at?(location)
    (show_child_links_at == location.to_s) && children.any?
  end
end
