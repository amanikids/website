class Redirector
  def initialize(app, map={})
    @app = app
    @map = map
  end

  def call(env)
    if url = @map[env['PATH_INFO']]
      [301, { 'Location' => url }, []]
    else
      @app.call(env)
    end
  end
end
