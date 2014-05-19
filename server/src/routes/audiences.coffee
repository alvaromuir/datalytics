# Audiences routes

module.exports = (server, db) ->

  server.get '/api/audiences/cookies', (req, res, next) ->
    db.Cookie.find (err, rcrds) ->
      return err if err
      rslts = {}
      rslts['count'] = rcrds.length
      rslts['segments'] = rcrds
      res.send rslts
      next()

  server.get '/api/audiences/segments', (req, res, next) ->
    db.Segment.find (err, rcrds) ->
      return err if err
      rslts = {}
      rslts['count'] = rcrds.length
      rslts['segments'] = rcrds
      res.send rslts
      next()
