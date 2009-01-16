class Content < ActiveRecord::Base
  named_scope :positioned, :order => :position
  named_scope :recent, :order => 'created_at DESC', :limit => 10

  acts_as_list :scope => :parent
  belongs_to :parent, :class_name => 'Content'
  has_many :children, :class_name => 'Content', :foreign_key => 'parent_id', :dependent => :destroy
  has_many :photos, :order => :position
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
    [body, footer, sidebar, one_time_donation_text, monthly_donation_text].grep(expression).any?
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
    '/' + slugs.join('/') if slugs.any?
  end

  def photo
    (photos.first || Photo.new).photo
  end

  def slugs
    slugs = parent ? parent.slugs + [slug] : [slug]
    slugs.compact
  end
end