(function() {
  define(function(require) {
    'use strict';
    var angular, app, controllers, directives, services;
    angular = require('angular');
    services = require('services/services');
    controllers = require('controllers/controllers');
    directives = require('directives/directives');
    app = angular.module('datalytics', ['datalytics']);
    return app.init = function() {
      return angular.bootstrap(document(['datalytics']));
    };
  });

}).call(this);
