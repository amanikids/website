class Gallery < Content
  validates_presence_of :title, :slug
  validates_format_of :slug, :with => /^[a-z0-9-]+$/
end