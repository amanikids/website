class Subscription < ActiveRecord::Base
  validates_presence_of :name, :email
  validates_confirmation_of :email
  validates_email_veracity_of :email, :domain_check => false
end
