class Share < ActiveRecord::Base
  after_create :deliver_share_created
  attr_accessor :from_address, :from_name, :to_address, :to_name, :message
  belongs_to :content

  validates_presence_of :from_name, :from_address, :to_name, :to_address
  validates_email_veracity_of :from_address, :to_address, :domain_check => false

  def from
    format_email(from_name, from_address)
  end

  def subject
    "#{from_name} just sent you a link to Amani Children's Home."
  end

  def to
    format_email(to_name, to_address)
  end

  private

  def deliver_share_created
    Mailer.deliver_share_created(self)
  end

  def format_email(name, address)
    "#{name} <#{address}>"
  end
end
