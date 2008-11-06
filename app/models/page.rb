class Page < Content
  attr_accessor :continue_editing
  validates_presence_of :body
end
