require ['config', 'app'], (config, app) ->
  requirejs.config(config)
  app()
