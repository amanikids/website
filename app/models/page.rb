class Page < Content
  has_attached_file :photo, :styles => { :large => '500x500#', :small => '120x120#' }, :default_style => :large
  validates_presence_of :title, :slug, :body
  validates_format_of :slug, :with => /^[a-z0-9-]+$/
end
