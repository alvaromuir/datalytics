# DataStore configuration

_        = require 'lodash'
mongoose = require 'mongoose'

Schema   = mongoose.Schema

tools = require './tools'
models_dir = __dirname + '/models'
models = {}

module.exports = (host, name) ->
    schemas = {}
    models_array = tools.loadModules models_dir
    mongo_uri= 'mongodb://' + host + '/' + name

    mongoose.connect mongo_uri

    _.each models_array, (model, index) ->
      schemas[index] = new Schema(model.model)
      models[index] = mongoose.model index, schemas[index]

    return models
