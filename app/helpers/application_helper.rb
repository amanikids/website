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

  def copyright_year(anchor_year)
    current_year = Time.now.year
    if current_year == anchor_year
      "#{anchor_year}"
    else
      "#{anchor_year}-#{current_year}"
    end
  end

  def display_first_only(counter)
    counter.zero? ? {} : { :style => 'display:none' }
  end

  def donation_form_for(donation_page, options = {})
    builder = donation_form_builder_for(donation_page, options)
    concat(form_tag(builder.form_action, options.except(:kind, :amount).merge(:method => :get)))
    yield builder
    concat(content_tag(:div, builder.hidden_fields.map { |name, value| hidden_field_tag(name, value) }.join("\n"), :class => :hidden_field))
    concat("\n</form>\n")
  end

  def slideshow_tag(content, options = {})
    if content.photos.any?
      options.reverse_merge! :size => '500x500', :style => :large
      render :partial => content.photos, :locals => { :style => options[:style], :size => options[:size], :slideshow => true }
    end
  end

  private

  def donation_form_builder_for(donation_page, options)
    case donation_page.online_donation_method
    when 'justgiving'
      JustGivingDonationFormBuilder.new(donation_page, self, options)
    when 'paypal'
      PayPalDonationFormBuilder.new(donation_page, self, options)
    end
  end

  class DonationFormBuilder
    def initialize(donation_page, template, options = {})
      @donation_page = donation_page
      @template      = template
      @kind          = options[:kind] || :one_time
      @amount        = options[:amount]
    end

    def hidden_fields
      shared_hidden_fields.merge(specific_hidden_fields).delete_if { |k, v| v.nil? }
    end

    def submit(value)
      @template.submit_tag(value)
    end

    def text_field(name)
      @template.text_field_tag(translate(name))
    end

    private

    def translate(name)
      name
    end
  end

  class JustGivingDonationFormBuilder < DonationFormBuilder
    def form_action
      'http://www.justgiving.com/charity/donate.asp'
    end

    private

    def shared_hidden_fields
      { :submitted => true, :FRSId => 249192, :FundraiserId => 182061, :SiteCategory => 'CharityMicroSite', :ProcessStepName => 'CharityLandingPage', :amount => @amount }
    end

    def specific_hidden_fields
      case @kind
      when :one_time
        { :_monthly => 0 }
      when :monthly
        { :_monthly => 1 }
      end
    end
  end

  class PayPalDonationFormBuilder < DonationFormBuilder
    def form_action
      PayPal.url
    end

    private

    def shared_hidden_fields
      { :business => @donation_page.paypal_account, :currency_code => @donation_page.currency, :no_shipping => 1, :rm => 1 }
    end

    def specific_hidden_fields
      case @kind
      when :one_time
        { :cmd => '_donations', :item_name => "One-time Donation to Amani Children's Home", :amount => @amount, :cn => 'Are you making this donation in honor of a friend or loved one? Please let us know.', :no_note => 0 }
      when :monthly
        { :cmd => '_xclick-subscriptions', :item_name => "Monthly Donation to Amani Children's Home", :a3 => @amount, :no_note => 1, :p3 => 1, :src => 1, :t3 => 'M' }
      end
    end

    def translate(name)
      if name == :amount
        (@kind == :monthly) ? :a3 : :amount
      else
        name
      end
    end
  end
end