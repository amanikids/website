class Gallery < Content
  validates_presence_of :title, :slug
  validates_format_of :slug, :with => /^[a-z0-9-]+$/

  def gallery?
    true
  end

  def parent_and_child
    [self, children.first]
  end

  def path
    "#{parent.path}/#{slug}"
  end
end