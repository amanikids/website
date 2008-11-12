class Home < Content
  validates_presence_of :title, :body

  def path
    nil
  end
end