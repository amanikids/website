class Content < ActiveRecord::Base
  named_scope :positioned, :order => :position
  named_scope :recent, :order => 'created_at DESC', :limit => 10

  acts_as_list :scope => :parent
  belongs_to :parent, :class_name => 'Content'
  has_many :children, :class_name => 'Content', :foreign_key => 'parent_id', :dependent => :destroy
  validates_uniqueness_of :slug, :allow_nil => true

  attr_accessor :continue_editing
  has_attached_file :photo, :styles => { :large => '500x500#', :gallery => '368x500#', :small => '120x120#' }, :default_style => :large

  def self.find_by_slugs(*slugs)
    slugs = slugs.dup

    slug = slugs.shift
    content = find_all_by_slug(slug).find { |c| c.path == "/#{slug}" } || raise(ActiveRecord::RecordNotFound)

    slugs.each do |slug|
      content = content.children.find_by_slug(slug) || raise(ActiveRecord::RecordNotFound)
    end

    content
  end

  def generation
    parent ? parent.children.positioned: [self]
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