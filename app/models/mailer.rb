class Mailer < ActionMailer::Base
  def share_created(share)
    from ActionMailer::Configuration.site
    reply_to share.from
    recipients share.to
    subject 'A page at amanikids.org' # FIXME
    body :message => share.message, :url => content_url(share.content.slugs)
  end
end
