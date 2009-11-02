$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..', 'vendor', 'taps-0.2.19', 'lib')))

module Tapsuey
  mattr_accessor :scheme
  mattr_accessor :host
  mattr_accessor :port
  mattr_accessor :username
  mattr_accessor :password
  mattr_accessor :chunk_size

  def self.pull
    require 'taps/client_session'
    Taps::ClientSession.start(local_database_url, remote_database_url, chunk_size) do |session|
      session.cmd_receive
    end
  end

  self.scheme     = 'http'
  self.host       = nil
  self.port       = nil
  self.username   = 'tapsuey'
  self.password   = nil
  self.chunk_size = 1000

  def self.local_database_url
    database_yml = Rails.configuration.database_configuration
    build_database_url(database_yml.fetch(Rails.env))
  end

  def self.remote_database_url
    URI::Generic.build({}).tap do |uri|
      uri.scheme   = scheme
      uri.user     = username
      uri.password = password
      uri.host     = host
      uri.port     = port
      uri.path     = '/tapsuey'
    end
  end

  def self.taps_database_url
    build_database_url('adapter' => 'sqlite3', 'database' => 'tmp/sessions/tapsuey.sqlite3')
  end

  private

  # Blatantly stolen, then modified, from heroku gem.
  def self.build_database_url(conf)
    return "sqlite://#{conf['database']}" if conf['adapter'] == 'sqlite3'

    conf['adapter']  = 'postgres' if conf['adapter'] == 'postgresql'
    conf['encoding'] = 'utf8'     if conf['encoding'] == 'unicode' or conf['encoding'].nil?

    URI::Generic.build({}).tap do |uri|
      uri.scheme   = conf['adapter']
      uri.user     = conf['user'] || conf['username']
      uri.password = conf['password']
      uri.host     = conf['host'] || conf['hostname'] || '127.0.0.1'
      uri.port     = conf['port']
      uri.path     = '/' + conf['database']
      uri.query    = "encoding=#{conf['encoding']}"
    end
  end
end
