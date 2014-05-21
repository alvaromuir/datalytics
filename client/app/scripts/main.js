(function() {
  require(['config', 'app'], function(config, app) {
    requirejs.config(config);
    return app();
  });

}).call(this);
