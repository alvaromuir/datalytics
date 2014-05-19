dataStore      = require '../ds'
business_days  = require './business_days'
media          = require './media'
audiences      = require './audiences'



module.exports = (server, db_host, db_name, db_port) ->

  # initialize database
  dataStore.init(db_host, db_name, db_port)
  db = dataStore.models()

  business_days server, db
  media server, db
  audiences server, db

  # Just a test, move along. Nothing to see here
  server.get '/hello/:name', (req, res, next) ->
    res.send
      hello: req.params.name
      date: new Date
    next()

  server.get '/', (req, res, next) ->
    resObj =
      sever: process.env.app_name
      remote: req.connection.remoteAddress
      date: new Date
      msg: 'for more info, try @alvaromuir'
    res.send resObj
    next()
