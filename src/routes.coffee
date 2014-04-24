# Application routes

_          = require 'lodash'
dataStore  = require './ds'

rsltsObj = (rcrds, category, criteria) ->
  rslts = {}
  rslts[category] = criteria
  rslts['placement count'] = rcrds.length
  rslts['Impressions']  = 0
  rslts['Clicks']       = 0
  rslts['CT TV LQS']    = 0
  rslts['VT TV LQS']    = 0
  rslts['TV LQS']       = 0
  rslts['placements']    = rcrds

  for rcrd in rcrds
    rslts['Impressions']   += rcrd._doc['Impressions']
    rslts['Clicks']        += rcrd._doc['Clicks']
    rslts['CT TV LQS']     += rcrd._doc['CT TV LQS']
    rslts['VT TV LQS']     += rcrd._doc['VT TV LQS']
    rslts['TV LQS']        += rcrd._doc['TV LQS']

  return rslts


module.exports = (server, db_host, db_name) ->
  # initialize database
  dataStore.init(db_host, db_name)
  db = dataStore.models()

  # Just a test, move along. Nothing to see here
  server.get '/hello/:name', (req, res, next) ->
    res.send
      hello: req.params.name
      date: new Date
    next()

  server.get '/api/placements', (req, res, next) ->
    db.Placements.find (err, rslts) ->
      return err if err
      count = rslts.length
      res.send 'total placements': count, placements: rslts

  # result by id
  server.get '/api/placements/id/:id', (req, res, next) ->
    db.Placements.findById req.params.id, (err, doc) ->
      return err if err
      if doc
        res.send doc
      else
        res.send {}

  # results by placement
  server.get '/api/placements/:placement', (req, res, next) ->
    db.Placements.find 'Placement': req.params.placement, (err, rcrds) ->
      return err if err
      rslts = rsltsObj(rcrds, 'placement', req.params.placement)
      res.send rslts

  # list campaigns
  server.get '/api/campaigns', (req, res, next) ->
    db.Placements.distinct 'Campaign', (err, rslts) ->
      return err if err
      count = rslts.length
      res.send 'total placements': count, campaigns: rslts

  # results by campaign
  server.get '/api/campaigns/:campaign_id', (req, res, next) ->
    db.Placements.find Campaign: req.params.campaign_id, (err, rcrds) ->
      return err if err
      rslts = rsltsObj(rcrds, 'campaign', req.params.campaign)
      res.send rslts


  # list sites
  server.get '/api/sites', (req, res, next) ->
    db.Placements.distinct 'Site (DFA)', (err, rslts) ->
      return err if err
      count = rslts.length
      res.send 'total placements': count, sites: rslts

  # results by site (DFA)
  server.get '/api/sites/:site', (req, res, next) ->
    db.Placements.find 'Site (DFA)': req.params.site, (err, rcrds) ->
      return err if err
      rslts = rsltsObj(rcrds, 'site', req.params.site)
      res.send rslts

  # list groups
  server.get '/api/groups', (req, res, next) ->
    db.Placements.distinct 'Placement Group', (err, rslts) ->
      return err if err
      count = rslts.length
      res.send 'total placements': count, 'placement groups': rslts

  # results by group
  server.get '/api/groups/:group', (req, res, next) ->
    db.Placements.find 'Placement Group': req.params.group, (err, rcrds) ->
      return err if err
      rslts = rsltsObj(rcrds, 'group', req.params.group)
      res.send rslts

  # list tactics
  server.get '/api/tactics', (req, res, next) ->
    db.Placements.distinct 'Placement Tactic', (err, rslts) ->
      return err if err
      count = rslts.length
      res.send 'total placements': count, 'placement tactics': rslts

  # results by tactic
  server.get '/api/tactics/:tactic', (req, res, next) ->
    db.Placements.find 'Placement Tactic': req.params.tactic, (err, rcrds) ->
      return err if err
      rslts = rsltsObj(rcrds, 'tactic', req.params.tactic)
      res.send rslts

  # list groups
  server.get '/api/segments', (req, res, next) ->
    db.Placements.distinct 'DMP Segment', (err, rslts) ->
      return err if err
      count = rslts.length
      res.send 'total placements': count, 'dmp segments': rslts

  # results by segment
  server.get '/api/segments/:segment', (req, res, next) ->
    db.Placements.find 'DMP Segment': req.params.segment, (err, rcrds) ->
      return err if err
      rslts = rsltsObj(rcrds, 'segment', req.params.segment)
      res.send rslts
