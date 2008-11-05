class Section < ActiveRecord::Base
  named_scope :ordered, :order => :position

  acts_as_list
  has_many :pages, :order => :position, :dependent => :destroy
  validates_presence_of :title

  def move_higher=(*args)
    move_higher
  end

  def move_lower=(*args)
    move_lower
  end
end
