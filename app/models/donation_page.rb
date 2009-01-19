class DonationPage < Content
  validates_presence_of :title, :body, :sidebar, :footer, :one_time_donation_title, :monthly_donation_title

  validates_presence_of :paypal_account, :if => :online_donation_method_is_paypal?
  validates_email_veracity_of :paypal_account, :domain_check => false
  validates_format_of :currency,                     :with => /^[A-Z]{3}$/,                  :if => :online_donation_method?, :message => 'should be 3 capital letters, like USD'
  validates_format_of :monthly_donation_amounts,     :with => /^(\s*\d+\s*)?(,\s*\d+\s*)*$/, :if => :online_donation_method?, :message => 'should be a comma-separated list of numbers'
  validates_format_of :monthly_donation_level_names, :with => /^(\s*\w+\s*)?(,\s*\w+\s*)*$/, :if => :online_donation_method?, :message => 'should be a comma-separated list of words'
  validates_format_of :one_time_donation_amounts,    :with => /^(\s*\d+\s*)?(,\s*\d+\s*)*$/, :if => :online_donation_method?, :message => 'should be a comma-separated list of numbers'
  validate :monthly_donation_level_names_match_amounts

  def currency_symbol
    case currency
    when 'CAD'; '$'
    when 'GBP'; '&pound;'
    when 'USD'; '$'
    else; "#{currency} " # note the trailing space
    end
  end

  def monthly_donation_amounts_list
    list(monthly_donation_amounts).map(&:to_i)
  end

  def monthly_donation_amounts_with_level_names
    monthly_donation_amounts_list.zip(monthly_donation_level_names_list)
  end

  def monthly_donation_level_names_list
    list(monthly_donation_level_names)
  end

  def one_time_donation_amounts_list
    list(one_time_donation_amounts).map(&:to_i)
  end

  def show_monthly_donations?
    online_donation_method? && monthly_donation_amounts_list.any?
  end

  def show_one_time_donations?
    online_donation_method? && one_time_donation_amounts_list.any?
  end

  private

  def list(list)
    list.to_s.split(',').map { |amount| amount.strip }
  end

  def monthly_donation_level_names_match_amounts
    if monthly_donation_amounts_list.any? && monthly_donation_level_names_list.size != monthly_donation_amounts_list.size
      errors.add(:monthly_donation_level_names, 'should have the same number of items as monthly donation amounts')
    end
  end

  def online_donation_method_is_paypal?
    self.online_donation_method == 'paypal'
  end
end
