class Page < ActiveRecord::Base
  belongs_to :section
  validates_presence_of :title, :slug, :body
  validates_format_of :slug, :with => /^[a-z0-9-]+$/
  has_param :slug
end
