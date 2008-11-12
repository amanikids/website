class Post < Content
  before_create :generate_slug
  validates_presence_of :title, :body

  private

  def generate_slug
    self.slug = Time.now.to_s(:number)
  end
end