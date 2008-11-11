class Section < Content
  validates_presence_of :title

  def path
    nil
  end
end
