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

  # results by placement
  server.get '/api/placements/:placement', (req, res, next) ->
    db.Placements.find 'Placement': req.params.placement, (err, rslts) ->
      return err if err
      count = rslts.length
      res.send total: count, placements: rslts

  # list campaigns
  server.get '/api/campaigns', (req, res, next) ->
    db.Placements.distinct 'Campaign', (err, rslts) ->
      return err if err
      count = rslts.length
      res.send total: count, campaigns: rslts

  # results by campaign
  server.get '/api/campaigns/:campaign_id', (req, res, next) ->
    db.Placements.find Campaign: req.params.campaign_id, (err, rslts) ->
      return err if err
      count = rslts.length
      res.send total: count, placements: rslts

  # list sites
  server.get '/api/sites', (req, res, next) ->
    db.Placements.distinct 'Site (DFA)', (err, rslts) ->
      return err if err
      count = rslts.length
      res.send total: count, sites: rslts

  # results by site (DFA)
  server.get '/api/sites/:site', (req, res, next) ->
    db.Placements.find 'Site (DFA)': req.params.site, (err, rslts) ->
      return err if err
      count = rslts.length
      res.send total: count, placements: rslts

  # list groups
  server.get '/api/groups', (req, res, next) ->
    db.Placements.distinct 'Placement Group', (err, rslts) ->
      return err if err
      count = rslts.length
      res.send total: count, 'placement groups': rslts

  # results by group
  server.get '/api/groups/:group', (req, res, next) ->
    db.Placements.find 'Placement Group': req.params.group, (err, rslts) ->
      return err if err
      count = rslts.length
      res.send total: count, placements: rslts

  # list tactics
  server.get '/api/tactics', (req, res, next) ->
    db.Placements.distinct 'Placement Tactic', (err, rslts) ->
      return err if err
      count = rslts.length
      res.send total: count, 'placement tactics': rslts

  # results by tactic
  server.get '/api/tactics/:tactic', (req, res, next) ->
    db.Placements.find 'Placement Tactic': req.params.tactic, (err, rslts) ->
      return err if err
      count = rslts.length
      res.send total: count, placements: rslts

  # list groups
  server.get '/api/segments', (req, res, next) ->
    db.Placements.distinct 'DMP Segment', (err, rslts) ->
      return err if err
      count = rslts.length
      res.send total: count, 'dmp segments': rslts

  # results by segment
  server.get '/api/segments/:segment', (req, res, next) ->
    db.Placements.find 'DMP Segment': req.params.segment, (err, rslts) ->
      return err if err
      count = rslts.length
      res.send total: count, placements: rslts
