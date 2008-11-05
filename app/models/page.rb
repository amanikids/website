class Page < ActiveRecord::Base
  acts_as_list :scope => :section
  belongs_to :section
  validates_presence_of :title, :slug, :body
  validates_format_of :slug, :with => /^[a-z0-9-]+$/
  has_param :slug

  attr_accessor :continue_editing

  def move_higher=(*args)
    move_higher
  end

  def move_lower=(*args)
    move_lower
  end
end
