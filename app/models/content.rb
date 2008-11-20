class Content < ActiveRecord::Base
  named_scope :positioned, :order => :position
  named_scope :recent, :order => 'created_at DESC', :limit => 10

  acts_as_list :scope => :parent
  belongs_to :parent, :class_name => 'Content'
  has_many :children, :class_name => 'Content', :foreign_key => 'parent_id', :dependent => :destroy

  attr_accessor :continue_editing
  has_attached_file :photo, :styles => { :large => '500x500#', :gallery => '368x500#', :small => '120x120#' }, :default_style => :large

  def generation
    parent ? parent.children.positioned: []
  end

  def move_higher=(*args)
    move_higher
  end

  def move_lower=(*args)
    move_lower
  end

  # Blog overrides navigation_children -> []
  def navigation_children
    children
  end

  def path
    parent ? "#{parent.path}/#{slug}" : "/#{slug}"
  end
end