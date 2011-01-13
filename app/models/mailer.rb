class Mailer < ActionMailer::Base
  def share_created(share)
    from "Amani Children's Home <#{ENV['GOOGLE_EMAIL']}>"
    reply_to share.from
    recipients share.to
    subject share.subject
    body :from_name => share.from_name, :message => share.message, :title => share.content.title, :url => content_url(share.content.slugs)
  end

  def subscription_created(subscription)
    from "Amani Children's Home <#{ENV['GOOGLE_EMAIL']}>"
    recipients subscription.email_with_name
    subject "Amani Children's Home e-Newsletter"
    body :name => subscription.name
  end
end
