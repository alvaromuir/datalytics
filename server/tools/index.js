// Generated by CoffeeScript 1.7.1
(function() {
  var fs, moment, path, _, _str;

  fs = require('fs');

  path = require('path');

  moment = require('moment');

  _ = require('lodash');

  _str = require('underscore.string');

  _.mixin(_str.exports());

  _.mixin(require('underscore.inflections'));

  module.exports = {
    loadModules: function(dir) {
      var modObj;
      modObj = modObj || {};
      require('fs').readdirSync(dir).forEach(function(file) {
        var module, modules;
        if (file === 'index.js') {
          return;
        }
        modules = {};
        module = _.capitalize(path.basename(file, '.js'));
        modules[module] = require(path.join(dir, file));
        return _.extend(modObj, modules);
      });
      return modObj;
    },
    capitalize: function(str) {
      return _.capitalize(str);
    },
    singularize: function(str) {
      return _.singularize(str);
    },
    currentMonth: function() {
      return moment().format('MMM');
    }
  };

}).call(this);
