(function() {
  define(['angular', 'domReady'], function(angular, domReady) {
    'use strict';
    return domReady(function() {
      return angular.bootstrap(document, ['datalytics']);
    });
  });

}).call(this);
