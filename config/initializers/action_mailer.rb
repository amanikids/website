ActionMailer::Configuration = Struct.new(:site_name, :site_address) do
  def site
    "#{site_name} <#{site_address}>"
  end
end.new

ActionMailer::Configuration.site_name    = "Amani Children's Home"
ActionMailer::Configuration.site_address = 'no-reply@amanikids.org'
