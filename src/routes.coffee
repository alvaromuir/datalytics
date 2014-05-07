# Application routes

dataStore  = require './ds'
_          = require 'lodash'

rsltsObj = (rcrds, category, criteria) ->
  rslts = {}
  rslts[category]            = criteria
  rslts['placement count']   = rcrds.length
  rslts['MediaCostM']        = 0
  rslts['ImpsM']             = 0
  rslts['ClicksM']           = 0
  rslts['Consumer - Homepage : Learn_Shop_Unique: Click-through Conversions'] = 0
  rslts['Consumer - Homepage : Learn_Shop_Unique: View-through Conversions'] = 0
  rslts['Consumer - Remarketing : Loop Qual Success_FiOS TV: Click-through Conversions'] = 0
  rslts['Consumer - Remarketing : Loop Qual Success_FiOS TV: View-through Conversions'] = 0
  rslts['Consumer - Remarketing : Loop Qual Success_FiOS Internet: Click-through Conversions'] = 0
  rslts['Consumer - Remarketing : Loop Qual Success_FiOS Internet: View-through Conversions'] = 0
  rslts['Consumer - Remarketing : Loop Qual Success_CHSI: Click-through Conversions'] = 0
  rslts['Consumer - Remarketing : Loop Qual Success_CHSI: View-through Conversions'] = 0
  rslts['Consumer - Order Confirmation : GO CHSI Order - AM: Click-through Conversions'] = 0
  rslts['Consumer - Order Confirmation : GO CHSI Order - AM: View-through Conversions'] = 0
  rslts['Consumer - Order Confirmation : GO CHSI Order - NC: Click-through Conversions'] = 0
  rslts['Consumer - Order Confirmation : GO CHSI Order - NC: View-through Conversions'] = 0
  rslts['Consumer - Order Confirmation : GO FiOS Internet Order - AM: Click-through Conversions'] = 0
  rslts['Consumer - Order Confirmation : GO FiOS Internet Order - AM: View-through Conversions'] = 0
  rslts['Consumer - Order Confirmation : GO FiOS Internet Order - NC: Click-through Conversions'] = 0
  rslts['Consumer - Order Confirmation : GO FiOS Internet Order - NC: View-through Conversions'] = 0
  rslts['Consumer - Order Confirmation : GO FiOS TV Order - AM: Click-through Conversions'] = 0
  rslts['Consumer - Order Confirmation : GO FiOS TV Order - AM: View-through Conversions'] = 0
  rslts['Consumer - Order Confirmation : GO FiOS TV Order - NC: Click-through Conversions'] = 0
  rslts['Consumer - Order Confirmation : GO FiOS TV Order - NC: View-through Conversions'] = 0
  rslts['Consumer - Homepage : VPM_2013: Click-through Conversions'] = 0
  rslts['Consumer - Homepage : VPM_2013: View-through Conversions'] = 0
  rslts['GoodVisitsM']       = 0
  rslts['CTGoodVisitsM']     = 0
  rslts['TVLQSm']            = 0
  rslts['CTTVLQSm']          = 0
  rslts['Total LQS']         = 0
  rslts['TVOrdersM']         = 0
  rslts['CTTVOrdersM']       = 0
  rslts['Internet Orders']   = 0
  rslts['CHSI Orders']       = 0
  rslts['Total Orders']      = 0
  rslts['Total VisitsM']     = 0

  for rcrd in rcrds
    doc = rcrd._doc
    _.forIn doc, (val, key) ->
      rslts[key] += parseInt(doc[key]) if not isNaN doc[key]

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

  server.get '/api/placements/', (req, res, next) ->
    db.Placements.find (err, rcrds) ->
      return err if err
      rslts = _.without rslts, ''
      rslts = rsltsObj(rcrds, 'placement', 'all')
      res.send rslts
      next()

  # result by id
  server.get '/api/placements/id/:id', (req, res, next) ->
    db.Placements.findById req.params.id, (err, doc) ->
      return err if err
      if doc
        res.send doc
        next()
      else
        res.send error: 'record with id '+req.params.id+' not found'
        next()

  # results by placement
  server.get '/api/placements/:placement', (req, res, next) ->
    db.Placements.find 'Placement': req.params.placement, (err, rcrds) ->
      return err if err
      rslts = rsltsObj(rcrds, 'placement', req.params.placement)
      res.send rslts
      next()

  # list campaigns
  server.get '/api/campaigns', (req, res, next) ->
    db.Placements.distinct 'Campaign', (err, rslts) ->
      return err if err
      rslts = _.without rslts, ''
      count = rslts.length
      res.send 'total campaigns': count, campaigns: rslts
      next()

  # results by campaign
  server.get '/api/campaigns/:campaign', (req, res, next) ->
    db.Placements.find Campaign: req.params.campaign, (err, rcrds) ->
      return err if err
      rslts = rsltsObj(rcrds, 'campaign', req.params.campaign)
      res.send rslts
      next()

  # list sites
  server.get '/api/sites', (req, res, next) ->
    db.Placements.distinct 'Site (DFA)', (err, rslts) ->
      return err if err
      rslts = _.without rslts, ''
      count = rslts.length
      res.send 'total sites': count, sites: rslts
      next()

  # results by site (DFA)
  server.get '/api/sites/:site', (req, res, next) ->
    db.Placements.find 'Site (DFA)': req.params.site, (err, rcrds) ->
      return err if err
      rslts = rsltsObj(rcrds, 'site', req.params.site)
      res.send rslts
      next()

  # list groups
  server.get '/api/mobile/tablet/tactic', (req, res, next) ->
    db.Placements.distinct 'Mobile/Tablet Tactic', (err, rslts) ->
      return err if err
      rslts = _.without rslts, ''
      count = rslts.length
      res.send 'total mobile/tablic tacitcs': count, 'mobile/tablic tacitcs': rslts
      next()

  # results by group
  server.get '/api/mobile/tablet/tactic/:tacic', (req, res, next) ->
    db.Placements.find 'Mobile/Tablet Tactic': req.params.tactic, (err, rcrds) ->
      return err if err
      rslts = rsltsObj(rcrds, 'mobile/tablic tacitc', req.params.tactic)
      res.send rslts
      next()

  # list tactics
  server.get '/api/tactics', (req, res, next) ->
    db.Placements.distinct 'Placement Tactic', (err, rslts) ->
      return err if err
      rslts = _.without rslts, ''
      count = rslts.length
      res.send 'total tactics': count, 'placement tactics': rslts
      next()

  # results by tactic
  server.get '/api/tactics/:tactic', (req, res, next) ->
    db.Placements.find 'Placement Tactic': req.params.tactic, (err, rcrds) ->
      return err if err
      rslts = rsltsObj(rcrds, 'tactic', req.params.tactic)
      res.send rslts
      next()

  # list groups
  server.get '/api/segments', (req, res, next) ->
    db.Placements.distinct 'DMP Segment', (err, rslts) ->
      return err if err
      count = rslts.length
      res.send 'total segments': count, 'dmp segments': rslts
      next()

  # results by segment
  server.get '/api/segments/:segment', (req, res, next) ->
    db.Placements.find 'DMP Segment': req.params.segment, (err, rcrds) ->
      return err if err
      rslts = rsltsObj(rcrds, 'segment', req.params.segment)
      res.send rslts
      next()

  # list months
  server.get '/api/dates', (req, res, next) ->
    db.Placements.distinct 'Date', (err, rslts) ->
      return err if err
      rslts = _.without rslts, ''
      count = rslts.length
      res.send 'total dates': count, 'dates': rslts
      next()

  # results by month
  server.get '/api/dates/:date', (req, res, next) ->
    db.Placements.find 'Date': req.params.date, (err, rcrds) ->
      return err if err
      rslts = rsltsObj(rcrds, 'date', req.params.date)
      res.send rslts
      next()
