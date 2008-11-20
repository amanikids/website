class Share < ActiveRecord::Base
  after_create :deliver_share_created
  attr_accessor :from, :to, :message
  belongs_to :content

  validates_presence_of :from, :to
  validates_email_veracity_of :from, :to, :message => 'is invalid'

  private

  def deliver_share_created
    Mailer.deliver_share_created(self)
  end
end
