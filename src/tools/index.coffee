# App utils
fs      = require 'fs'
path    = require 'path'
_       = require 'lodash'
_str    = require 'underscore.string'


_.mixin _str.exports()
_.mixin require 'underscore.inflections'

module.exports =

  loadModules: (dir) ->
    modObj = modObj || {}

    require('fs').readdirSync(dir).forEach (file) ->
      return if file == 'index.js'
      modules = {}
      module = _.capitalize path.basename(file, '.js')
      modules[module] = require path.join(dir,file)
      _.extend modObj, modules

    return modObj