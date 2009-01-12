ActionMailer::Configuration = Struct.new(:site_name, :site_address) do
  def site
    "#{site_name} <#{site_address}>"
  end
end.new

# FIXME set up proper email addresses
# FIXME configure spf record to allow mail from new server as well
ActionMailer::Configuration.site_name    = "Amani Children's Home"
ActionMailer::Configuration.site_address = 'no-reply@amanikids.joyeurs.com'
