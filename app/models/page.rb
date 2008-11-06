class Page < Content
  attr_accessor :continue_editing
  validates_presence_of :title, :slug, :body
  validates_format_of :slug, :with => /^[a-z0-9-]+$/

  def path
    "#{parent.path}/#{slug}"
  end
end
