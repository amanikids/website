class Subscription < ActiveRecord::Base
  validates_presence_of :name, :email
  validates_confirmation_of :email
  validates_email_veracity_of :email, :domain_check => false

  after_create :deliver_subscription_created

  private

  def deliver_subscription_created
    Mailer.deliver_subscription_created(self)
  end
end
