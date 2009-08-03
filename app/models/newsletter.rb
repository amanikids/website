class Newsletter < ActiveRecord::Base
  named_scope             :by_published_on, :order => :published_on

  before_validation       :adjust_published_on_to_the_first_of_the_month, :if => :published_on?
  validates_presence_of   :published_on
  validates_uniqueness_of :published_on

  attr_accessor           :continue_editing

  def self.find_by_slug!(slug)
    if slug =~ /^(20\d{2})(0[1-9]|1[0-2])$/
      find_by_published_on!(Date.new($1.to_i, $2.to_i))
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def path
    "/newsletters/#{slug}"
  end

  def slug
    published_on.strftime('%Y%m')
  end

  def title
    published_on.strftime('Amani Newsletter - %B %Y')
  end

  private

  def adjust_published_on_to_the_first_of_the_month
    self.published_on = self.published_on.at_beginning_of_month
  end
end
