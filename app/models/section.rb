class Section < Content
  validates_presence_of :title

  def path
    ''
  end
end
