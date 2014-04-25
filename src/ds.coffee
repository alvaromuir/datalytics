# DataStore configuration
_             = require 'lodash'
mongoose      = require 'mongoose'

tools         = require './tools'
models_dir    = __dirname + '/models'
models_array  = tools.loadModules models_dir
modelsObj     = {}

module.exports =
  init: (host, name, port) ->
    mongo_uri= 'mongodb://' + host
    mongo_uri += ':' + port if port
    mongo_uri += '/' + name

    mongoose.connect mongo_uri
    
    console.log 'datastore connected at ' + mongo_uri if process.env['NODE_ENV'] != 'production'

  status: () ->
    status = state: 'not ready'
    if mongoose.connection.readyState is 1
      status.state = 'ready'
    return status

  models: () ->
    if _.isEmpty modelsObj
      _.each models_array, (model, index) ->
        modelsObj[index] = mongoose.model index, mongoose.Schema(model.model)
      return modelsObj

    return modelsObj
