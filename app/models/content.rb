class Content < ActiveRecord::Base
  named_scope :ordered, :order => :position

  acts_as_list :scope => :parent
  belongs_to :parent, :class_name => 'Content'
  has_many :children, :class_name => 'Content', :foreign_key => 'parent_id', :order => :position, :dependent => :destroy
  has_param :slug

  validates_presence_of :title, :slug
  validates_format_of :slug, :with => /^[a-z0-9-]+$/

  def move_higher=(*args)
    move_higher
  end

  def move_lower=(*args)
    move_lower
  end
end