class Article < ActiveRecord::Base
  acts_as_list :scope => :newsletter
  belongs_to :newsletter
  has_many :photos, :order => :position, :as => :content
  validates_presence_of :title
  attr_accessor :continue_editing

  def move_higher=(*args)
    move_higher
  end

  def move_lower=(*args)
    move_lower
  end
end
