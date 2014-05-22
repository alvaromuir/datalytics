(function() {
  require(['config'], function(config) {
    requirejs.config(config);
    return require(['app', 'controllers/dmp'], function(app) {
      return require(['bootstrap'], function() {});
    });
  });

}).call(this);
