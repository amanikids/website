class DonationPage < Content
  validates_presence_of :title, :body, :sidebar, :footer, :one_time_donation_title, :monthly_donation_title

  validates_presence_of :paypal_account, :if => :online_donation_method_is_paypal?
  validates_email_veracity_of :paypal_account, :domain_check => false
  validates_format_of :currency,         :with => /^[A-Z]{3}$/,                 :if => :online_donation_method?, :message => 'should be 3 capital letters, like USD'
  validates_format_of :donation_amounts, :with => /^(\s*\d+\s*)(,\s*\d+\s*)+$/, :if => :online_donation_method?, :message => 'should be a comma-separated list of numbers'

  def donation_amounts_list
    donation_amounts.split(',').map { |amount| amount.strip.to_i }
  end

  private

  def online_donation_method_is_paypal?
    self.online_donation_method == 'paypal'
  end
end
