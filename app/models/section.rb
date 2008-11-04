class Section < ActiveRecord::Base
  has_many :pages, :order => :position
end
