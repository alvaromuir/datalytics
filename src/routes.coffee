# Application routes

_       = require 'lodash'
db_init = require './db'


module.exports = (server, db_host, db_name) ->
  # initialize database
  db = db_init(db_host, db_name)

  # Just a test
  server.get '/hello/:name', (req, res, next) ->
    res.send
      hello: req.params.name
      date: new Date
    next()

  server.get '/api/placements', (req, res, next) ->
    db.Placements.find (err, rslts) ->
      return err if err
      count = rslts.length
      res.send total: count, placements: rslts


  # result by id
  server.get '/api/placements/:id', (req, res, next) ->
    db.Placements.findById req.params.id, (err, doc) ->
      return err if err
      res.send doc

  # results by campaign
  server.get '/api/placements/campaign/:campaign_id', (req, res, next) ->
    db.Placements.find Campaign: req.params.campaign_id, (err, rslts) ->
      return err if err
      count = rslts.length
      res.send total: count, placements: rslts

  # results by site (DFA)
  server.get '/api/placements/site/:site', (req, res, next) ->
    db.Placements.find 'Site (DFA)': req.params.site, (err, rslts) ->
      return err if err
      count = rslts.length
      res.send total: count, placements: rslts

  # results by placement
  server.get '/api/placements/placement/:placement', (req, res, next) ->
    db.Placements.find 'Placement': req.params.placement, (err, rslts) ->
      return err if err
      count = rslts.length
      res.send total: count, placements: rslts

  # results by group
  server.get '/api/placements/group/:group', (req, res, next) ->
    db.Placements.find 'Placement Group': req.params.group, (err, rslts) ->
      return err if err
      count = rslts.length
      res.send total: count, placements: rslts

  # results by tactic
  server.get '/api/placements/tactic/:tactic', (req, res, next) ->
    db.Placements.find 'Placement Tactic': req.params.tactic, (err, rslts) ->
      return err if err
      count = rslts.length
      res.send total: count, placements: rslts

  # results by segment
  server.get '/api/placements/segment/:segment', (req, res, next) ->
    db.Placements.find 'DMP Segment': req.params.segment, (err, rslts) ->
      return err if err
      count = rslts.length
      res.send total: count, placements: rslts
