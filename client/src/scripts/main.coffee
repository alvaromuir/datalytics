require ['config'], (config) ->
  requirejs.config(config)

  require ['app','controllers/dmp'], (app) ->
    require ['bootstrap'], () ->
