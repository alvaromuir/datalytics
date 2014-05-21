# Angular bootstrap; Utilized require's domReady

define ['angular', 'app', 'domReady'], (ng, domReady) ->
  'use strict'

  require ['domReady!'], (document) ->
    ng.bootstrap document, ['app']
