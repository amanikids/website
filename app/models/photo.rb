class Photo < ActiveRecord::Base
  acts_as_list :scope => :content
  belongs_to :content, :polymorphic => true, :touch => true

  has_attached_file :photo, :styles => {
    :large      => '500x500#',
    :gallery    => '368x500#',
    :small      => '200x200#',
    :newsletter => '200x',
    :thumbnail  => '120x120#'
  }, :convert_options => {
    :newsletter => ''
  }, :default_style => :large, :whiny_thumbnails => true

  validates_attachment_presence :photo
  delegate :url, :to => :photo

  def self.random(number)
    all.shuffle.first(number)
  end

  def move_higher=(*args)
    move_higher
  end

  def move_lower=(*args)
    move_lower
  end
end
