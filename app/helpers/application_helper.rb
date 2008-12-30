module ApplicationHelper
  def breadcrumbs(page)
    parents = []

    parent = page.parent
    until parent.is_a?(Home)
      parents.unshift(parent)
      parent = parent.parent
    end

    parents.map! do |parent|
      link_to_if(parent.path, parent.title, parent.path) + ':'
    end

    parents.join(' ')
  end

  def display_first_only(counter)
    counter.zero? ? {} : { :style => 'display:none' }
  end

  def monthly_donation_form(donation_page, amount = nil, &block)
    donation_form(monthly_donation_fields(donation_page.paypal_account, amount, donation_page.currency), &block)
  end

  def one_time_donation_form(donation_page, amount = nil, &block)
    donation_form(one_time_donation_fields(donation_page.paypal_account, amount, donation_page.currency), &block)
  end

  def slideshow_tag(content, options = {})
    options.reverse_merge! :size => '500x500', :style => :large
    render :partial => (content.photos.any? ? content.photos : [Photo.new]), :locals => { :style => options[:style], :size => options[:size], :slideshow => true }
  end


  private

  def donation_form(fields = {})
    concat(form_tag(ActiveMerchant::Billing::Integrations::Paypal.service_url, :method => :get))
    yield
    concat(content_tag(:div, fields.map { |name, value| hidden_field_tag(name, value) }.join("\n"), :class => :field))
    concat("\n</form>\n")
  end

  def donation_fields(account, currency, command, item_name)
    { :business => account, :currency_code => currency, :cmd => command, :item_name => item_name, :no_note => 1, :no_shipping => 1, :rm => 1 }
  end

  def monthly_donation_fields(account, amount, currency)
    { :a3 => amount, :p3 => 1, :src => 1, :t3 => 'M' }.merge(donation_fields(account, currency, '_xclick-subscriptions', "Monthly Donation to Amani Children's Home")).delete_if { |k, v| v.nil? }
  end

  def one_time_donation_fields(account, amount, currency)
    { :amount => amount}.merge(donation_fields(account, currency, '_donations', "One-time Donation to Amani Children's Home")).delete_if { |k, v| v.nil? }
  end
end