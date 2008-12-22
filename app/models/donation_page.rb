class DonationPage < Content
  validates_presence_of :title, :body, :sidebar, :footer

  validates_email_veracity_of :paypal_account, :domain_check => false, :message => 'is invalid'
  validates_format_of :currency,         :with => /^[A-Z]{3}$/,                 :if => :paypal_account?, :message => 'should be 3 capital letters, like USD'
  validates_format_of :donation_amounts, :with => /^(\s*\d+\s*)(,\s*\d+\s*)+$/, :if => :paypal_account?, :message => 'should be a comma-separated list of numbers'

  def donation_amounts_list
    donation_amounts.split(',').map { |amount| amount.strip.to_i }
  end
end
