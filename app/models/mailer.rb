class Mailer < ActionMailer::Base
  def share_created(share)
    from ActionMailer::Configuration.site
    reply_to share.from
    recipients share.to
    subject share.subject
    body :message => share.message, :title => share.content.title, :url => content_url(share.content.slugs)
  end

  def subscription_created(subscription)
    from ActionMailer::Configuration.site
    recipients subscription.email_with_name
    subject "Amani Children's Home e-Newsletter"
    body :name => subscription.name
  end
end
