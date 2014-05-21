# Main app

define (require) ->
  'use strict'

  angular      = require 'angular'
  services     = require 'services/services'
  controllers  = require 'controllers/controllers'
  directives   = require 'directives/directives'

  app = angular.module 'datalytics', ['datalytics']

  app.init = ->
    angular.bootstrap document ['datalytics']
