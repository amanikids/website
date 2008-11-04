class Section < ActiveRecord::Base
  named_scope :ordered, :order => :position
  has_many :pages, :order => :position
  validates_presence_of :title
end
