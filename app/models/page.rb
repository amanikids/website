class Page < Content
  attr_accessor :continue_editing
  has_param :slug
  validates_presence_of :title, :slug, :body
  validates_format_of :slug, :with => /^[a-z0-9-]+$/
end
