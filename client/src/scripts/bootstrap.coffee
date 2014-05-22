# Angular bootstrap; Utilized require's domReady

define ['angular', 'domReady'], (angular, domReady) ->
  'use strict'

  domReady ->
    # console.log 'test'
    angular.bootstrap document, ['datalytics']
