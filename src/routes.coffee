# Application routes
db = require './db'

module.exports = (server) ->

  # Just a test
  server.get '/hello/:name', (req, res, next) ->
    res.send
      hello: req.params.name
      date: new Date
    next()

  server.get '/placement', (req, res, next) ->
    db.placement.find {}, (err, rcrd) ->
      res.send rcrd
