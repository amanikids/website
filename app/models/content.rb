class Content < ActiveRecord::Base
  named_scope :ordered, :order => :position

  acts_as_list :scope => :parent
  belongs_to :parent, :class_name => 'Content'
  has_many :children, :class_name => 'Content', :foreign_key => 'parent_id', :order => :position, :dependent => :destroy

  attr_accessor :continue_editing
  has_attached_file :photo, :styles => { :large => '500x500#', :gallery => '368x500#', :small => '120x120#' }, :default_style => :large

  def move_higher=(*args)
    move_higher
  end

  def move_lower=(*args)
    move_lower
  end
end