# Server setup testing

dotenv    = require 'dotenv'
chai      = require 'chai'
request   = require 'request'

ds        = require '../ds'

should    = chai.should()
expect    = chai.expect
assert    = chai.assert

dotenv.load()
env =
  app_host: process.env.app_host or '0.0.0.0'
  app_port: parseInt process.env.app_port or 3000
  app_name: process.env.app_name
  db_host: process.env.db_host or 'localhost'
  db_name: process.env.db_name
  db_port: parseInt process.env.db_port or 27017

app_url = 'http://' + env.app_host + ':' + env.app_port

describe 'The application server', () ->

  before (done) ->
    request app_url, (err, res, data) ->
      # in case the server is already running . . .
      if not err and res.statusCode is 200
        done()
      else
        app = require '../server'
        done()

  describe 'when listening', () ->
    it 'should respond to GET request', (done) ->
      request app_url, (err, res, data) ->
        if not err and res.statusCode is 200
          body = JSON.parse data
          expect(body.code).to.not.equal 'ResourceNotFound'
          expect(body.server).to.equal env.app_name
          done()
