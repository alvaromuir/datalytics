(function() {
  define(['angular', 'app', 'domReady'], function(ng, domReady) {
    'use strict';
    return require(['domReady!'], function(document) {
      return ng.bootstrap(document, ['app']);
    });
  });

}).call(this);
