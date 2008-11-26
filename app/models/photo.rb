class Photo < ActiveRecord::Base
  acts_as_list :scope => :content
  belongs_to :content
  has_attached_file :photo, :styles => { :large => '500x500#', :gallery => '368x500#', :small => '120x120#' }, :default_style => :large, :whiny_thumbnails => true
  validates_attachment_presence :photo

  def move_higher=(*args)
    move_higher
  end

  def move_lower=(*args)
    move_lower
  end
end
