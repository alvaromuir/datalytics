# Application routes

dataStore  = require './ds'

rsltsObj = (rcrds, category, criteria) ->
  rslts = {}
  rslts[category]            = criteria
  rslts['placement count']   = rcrds.length
  rslts['Impressions']       = 0
  rslts['Clicks']            = 0
  rslts['CT TV LQS']         = 0
  rslts['VT TV LQS']         = 0
  rslts['TV LQS']            = 0
  rslts['Internet Orders']   = 0
  rslts['TV Orders']         = 0

  for rcrd in rcrds
    if not isNaN rcrd['Impressions']
      rslts['Impressions']    += rcrd['Impressions']
    rslts['Clicks']           += rcrd['Clicks'] if not isNaN rcrd['Clicks']
    rslts['CT TV LQS']        += rcrd['CT TV LQS'] if not isNaN rcrd['CT TV LQS']
    rslts['VT TV LQS']        += rcrd['VT TV LQS'] if not isNaN rcrd['VT TV LQS']
    rslts['TV LQS']           += rcrd._doc['TV LQS'] if not isNaN rcrd._doc['TV LQS'] #._doc ?? not sure why i need this
    rslts['Internet Orders']  += rcrd['Internet Orders'] if not isNaN rcrd['Internet Orders']
    rslts['TV Orders']        += rcrd['TV Orders'] if not isNaN rcrd['TV Orders']


  rslts['Total Orders']      = rslts['Internet Orders'] + rslts['TV Orders']
  rslts['placements']        = rcrds

  return rslts


module.exports = (server, db_host, db_name, db_port) ->
  # initialize database
  dataStore.init(db_host, db_name, db_port)
  db = dataStore.models()

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

  server.get '/api/placements', (req, res, next) ->
    db.Placements.find (err, rcrds) ->
      return err if err
      rslts = rsltsObj(rcrds, 'placement', 'all')
      res.send rslts

  # result by id
  server.get '/api/placements/id/:id', (req, res, next) ->
    db.Placements.findById req.params.id, (err, doc) ->
      return err if err
      if doc
        res.send doc
      else
        res.send error: 'record with id '+req.params.id+' not found'

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
      res.send 'total campaigns': count, campaigns: rslts

  # results by campaign
  server.get '/api/campaigns/:campaign', (req, res, next) ->
    db.Placements.find Campaign: req.params.campaign, (err, rcrds) ->
      return err if err
      rslts = rsltsObj(rcrds, 'campaign', req.params.campaign)
      res.send rslts

  # list sites
  server.get '/api/sites', (req, res, next) ->
    db.Placements.distinct 'Site (DFA)', (err, rslts) ->
      return err if err
      count = rslts.length
      res.send 'total sites': count, sites: rslts

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
      res.send 'total groups': count, 'placement groups': rslts

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
      res.send 'total tactics': count, 'placement tactics': rslts

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
      res.send 'total segments': count, 'dmp segments': rslts

  # results by segment
  server.get '/api/segments/:segment', (req, res, next) ->
    db.Placements.find 'DMP Segment': req.params.segment, (err, rcrds) ->
      return err if err
      rslts = rsltsObj(rcrds, 'segment', req.params.segment)
      res.send rslts

  # list months
  server.get '/api/months', (req, res, next) ->
    db.Placements.distinct 'Month', (err, rslts) ->
      return err if err
      count = rslts.length
      res.send 'total months': count, 'months': rslts

  # results by month
  server.get '/api/months/:month', (req, res, next) ->
    db.Placements.find 'Month': req.params.month, (err, rcrds) ->
      return err if err
      rslts = rsltsObj(rcrds, 'month', req.params.month)
      res.send rslts
