# Server setup testing

dotenv    = require 'dotenv'
chai       = require 'chai'
request    = require 'request'
_          = require 'lodash'

tools      = require '../tools'
dataStore  = require '../ds'
db         = dataStore.models()

should     = chai.should()
expect     = chai.expect
assert     = chai.assert

dotenv.load()
env =
  app_host: process.env.app_host or '0.0.0.0'
  app_port: parseInt process.env.app_port or 3000
  app_name: process.env.app_name
  db_host: process.env.db_host or 'localhost'
  db_name: process.env.db_name
  db_port: parseInt process.env.db_port or 27017

dataStore.init(env.db_host, env.db_name, env.db_port)
app_url = 'http://' + env.app_host + ':' + env.app_port

# get factories
factory_array = tools.loadModules __dirname + '/factories'
factories = {}

_.each factory_array, (factory, index) ->
  factories[index.split('_')[0].toLowerCase()] = factory




describe 'The application server', ()  ->

  before (done) ->
    request app_url, (err, res, data) ->
      # in case the server is already running . . .
      if not err and res.statusCode is 200
        done()
      else
        app = require '../server'
        done()

  describe 'has placement routes that', () ->
    test_plcmnt = {}

    before (done) ->
      p1 = new db.Placements factories.placement
      p1.save (err, doc) ->
        throw err if err
        _.extend test_plcmnt, doc._doc
      done()


    after (done) ->
      # clean up
      db.Placements.findByIdAndRemove test_plcmnt._id, (err, rcrd) ->
        throw err if err
      done()

    it 'gets all placements', (done) ->
      test_url = app_url + '/api/placements'

      request test_url, (err, res, data) ->
        expect(res.statusCode).to.not.equal 404

        if not err and res.statusCode is 200
          body = JSON.parse data
          expect(body.placement).to.equal 'all'
        done();

    it 'can get a single placement by ID', (done) ->
      test_url = app_url + '/api/placements/id/' + test_plcmnt._id

      request test_url, (err, res, data) ->
        expect(res.statusCode).to.not.equal 404

        if not err and res.statusCode is 200
          body = JSON.parse data
          expect(body._id).to.equal test_plcmnt._id.toString()
        done();

    it 'gets all placements by placement name', (done) ->
      test_url = app_url + '/api/placements/' +  encodeURIComponent test_plcmnt['Placement']

      request test_url, (err, res, data) ->
        expect(res.statusCode).to.not.equal 404

        if not err and res.statusCode is 200
          body = JSON.parse data
          expect(body.placement).to.equal test_plcmnt['Placement']
        done();


    it 'gets a list of all campaigns', (done) ->
      criteria = 'campaigns'
      test_url = app_url + '/api/'  + criteria

      request test_url, (err, res, data) ->
        expect(res.statusCode).to.not.equal 404

        if not err and res.statusCode is 200
          body = JSON.parse data
          expect(_.contains(body[criteria], test_plcmnt['Campaign'])).to.equal true
        done();


    it 'gets campaigns by campaign name', (done) ->
      criteria = 'campaigns'
      test_url = app_url + '/api/'  + criteria + '/' + encodeURIComponent test_plcmnt['Campaign']

      request test_url, (err, res, data) ->
        expect(res.statusCode).to.not.equal 404

        if not err and res.statusCode is 200
          body = JSON.parse data
          expect(body[criteria]).to.equal test_plcmnt[criteria]
        done();


    it 'gets a list of all sites', (done) ->
      criteria = 'sites'
      test_url = app_url + '/api/'  + criteria

      request test_url, (err, res, data) ->
        expect(res.statusCode).to.not.equal 404

        if not err and res.statusCode is 200
          body = JSON.parse data
          expect(_.contains(body[criteria], test_plcmnt['Site (DFA)'])).to.equal true
        done();


    it 'gets all placements by site name', (done) ->
      criteria = 'sites'
      criteria_name = 'Site (DFA)'
      test_url = app_url + '/api/'  + criteria + '/' + encodeURIComponent test_plcmnt[criteria_name]

      request test_url, (err, res, data) ->
        expect(res.statusCode).to.not.equal 404

        if not err and res.statusCode is 200
          body = JSON.parse data
          expect(body[tools.singularize criteria]).to.equal test_plcmnt[criteria_name]
        done();


    it 'gets a list of all groups', (done) ->
      criteria = 'groups'
      criteria_name = 'Placement ' + tools.capitalize criteria
      criteria_key = tools.singularize criteria_name
      test_url = app_url + '/api/'  + criteria

      request test_url, (err, res, data) ->
        expect(res.statusCode).to.not.equal 404

        if not err and res.statusCode is 200
          body = JSON.parse data
          expect(_.contains(body[criteria_name.toLowerCase()], test_plcmnt[criteria_key])).to.equal true
        done();


    it 'gets all placements by group name', (done) ->
      criteria = 'groups'
      criteria_name = 'Placement ' + tools.capitalize criteria
      criteria_key = tools.singularize criteria_name
      test_url = app_url + '/api/'  + criteria + '/' + encodeURIComponent test_plcmnt[criteria_key]

      request test_url, (err, res, data) ->
        expect(res.statusCode).to.not.equal 404

        if not err and res.statusCode is 200
          body = JSON.parse data
          expect(body[tools.singularize criteria]).to.equal test_plcmnt[criteria_key]
        done();


    it 'gets a list of all tactics', (done) ->
      criteria = 'tactics'
      criteria_name = 'Placement ' + tools.capitalize criteria
      criteria_key = tools.singularize criteria_name
      test_url = app_url + '/api/'  + criteria

      request test_url, (err, res, data) ->
        expect(res.statusCode).to.not.equal 404

        if not err and res.statusCode is 200
          body = JSON.parse data
          expect(_.contains(body[criteria_name.toLowerCase()], test_plcmnt[criteria_key])).to.equal true
        done();


    it 'gets all placements by tactic name', (done) ->
      criteria = 'tactics'
      criteria_name = 'Placement ' + tools.capitalize criteria
      criteria_key = tools.singularize criteria_name
      test_url = app_url + '/api/'  + criteria + '/' + encodeURIComponent test_plcmnt[criteria_key]

      request test_url, (err, res, data) ->
        expect(res.statusCode).to.not.equal 404

        if not err and res.statusCode is 200
          body = JSON.parse data
          expect(body[tools.singularize criteria]).to.equal test_plcmnt[criteria_key]
        done();


    it 'gets a list of all segments', (done) ->
      criteria = 'segments'
      criteria_key = 'DMP Segment'
      test_url = app_url + '/api/'  + criteria

      request test_url, (err, res, data) ->
        expect(res.statusCode).to.not.equal 404

        if not err and res.statusCode is 200
          body = JSON.parse data
          expect(_.contains(body[criteria_key.toLowerCase()+'s'], test_plcmnt[criteria_key])).to.equal true
        done();


    it 'gets all placements by segment name', (done) ->
      criteria = 'segments'
      criteria_key = 'DMP Segment'
      test_url = app_url + '/api/'  + criteria + '/' + encodeURIComponent test_plcmnt[criteria_key]

      request test_url, (err, res, data) ->
        expect(res.statusCode).to.not.equal 404

        if not err and res.statusCode is 200
          body = JSON.parse data
          expect(body[tools.singularize criteria]).to.equal test_plcmnt[criteria_key]
        done();


    it 'gets a list of all months', (done) ->
      criteria = 'months'
      criteria_key = 'Month'
      test_url = app_url + '/api/'  + criteria

      request test_url, (err, res, data) ->
        expect(res.statusCode).to.not.equal 404

        if not err and res.statusCode is 200
          body = JSON.parse data
          expect(_.contains(body[criteria], test_plcmnt[criteria_key])).to.equal true
        done();

    it 'gets all placements by month', (done) ->
      criteria = 'months'
      criteria_key = 'Month'
      test_url = app_url + '/api/'  + criteria + '/' + encodeURIComponent test_plcmnt[criteria_key]

      request test_url, (err, res, data) ->
        expect(res.statusCode).to.not.equal 404

        if not err and res.statusCode is 200
          body = JSON.parse data
          expect(body[tools.singularize criteria]).to.equal test_plcmnt[criteria_key]
        done();
