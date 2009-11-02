class TapsueyServer
  def self.call(env)
    new.call(env)
  end

  def initialize
    require 'taps/config'
    Taps::Config.database_url      = Tapsuey.local_database_url
    Taps::Config.taps_database_url = Tapsuey.taps_database_url
    Taps::Config.login             = Tapsuey.username
    Taps::Config.password          = Tapsuey.password

    require 'taps/server'
    @app = Rack::URLMap.new('/tapsuey' => Taps::Server.new)
  end

  def call(env)
    @app.call(env)
  end
end
