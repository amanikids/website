class Share < ActiveRecord::Base
  attr_accessor :from, :to, :message
  belongs_to :content

  validates_presence_of :from, :to
  validates_email_veracity_of :from, :to, :message => 'is invalid'
end
