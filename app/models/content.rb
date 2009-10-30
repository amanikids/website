class Content < ActiveRecord::Base
  DEFAULT_DESCRIPTION = "Amani Children's Home, a non-profit home for orphans and street-children in Tanzania."
  DEFAULT_KEYWORDS    = 'AIDS orphans, street-children, orphanage, volunteer, Moshi, street-kids, Kilimanjaro, street-children, orphans, Africa, sponsor-a-child, Tanzania, AIDS kids'

  named_scope :sorted_by_date, :order => 'created_at DESC'
  named_scope :sorted_by_position, :order => :position
  named_scope :sorted_by_title, :order => :title
  named_scope :recent, :limit => 5

  acts_as_list :scope => :parent
  belongs_to :parent, :class_name => 'Content', :touch => true
  has_many :children, :class_name => 'Content', :foreign_key => 'parent_id', :dependent => :destroy
  has_many :photos, :order => :position, :as => :content
  has_many :shares
  validates_uniqueness_of :slug, :allow_nil => true

  attr_accessor :continue_editing

  def self.find_by_slugs(*slug_params)
    slug_params = slug_params.dup

    slug = slug_params.shift
    content = find_all_by_slug(slug).find { |c| c.path == "/#{slug}" } || raise(ActiveRecord::RecordNotFound)

    slug_params.each do |slug|
      content = content.children.find_by_slug(slug) || raise(ActiveRecord::RecordNotFound)
    end

    content
  end

  def any_text_matches?(expression)
    self.class.columns.select { |c| c.type == :text }.map { |c| self.send(c.name) }.grep(expression).any?
  end

  def description
    if raw_description.blank?
      parent ? parent.description : DEFAULT_DESCRIPTION
    else
      raw_description
    end
  end

  def generation
    parent ? parent.sorted_children : [self]
  end

  def keywords
    if raw_keywords.blank?
      parent ? parent.keywords : DEFAULT_KEYWORDS
    else
      parent ? "#{raw_keywords}, #{parent.keywords}" : raw_keywords
    end
  end

  def move_higher=(*args)
    move_higher
  end

  def move_lower=(*args)
    move_lower
  end

  # Blog overrides navigation_children -> []
  def navigation_children
    sorted_children
  end

  def next_page
    return if hide_next_page?

    if sorted_children.any?
      sorted_children.first
    else
      in_order_traversal
    end
  end

  def in_order_traversal
    case next_sibling
    when NilClass
      parent ? parent.in_order_traversal : nil
    when Section
      next_sibling.next_page
    else
      next_sibling
    end
  end

  def next_sibling
    @next_sibling ||= generation[generation.index(self) + 1]
  end

  def path
    '/' + slugs.join('/') if slugs.any?
  end

  def photo
    (photos.first || Photo.new).photo
  end

  def slugs
    slugs = parent ? parent.slugs + [slug] : [slug]
    slugs.compact
  end

  def sort_children_by_position?
    true
  end

  def sorted_children
    children.sorted_by_position
  end
end