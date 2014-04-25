dotenv    = require 'dotenv'
restify   = require 'restify'
bunyan		= require 'bunyan'

routes    = require './routes'
tools     = require './tools'

dotenv.load()
env =
	app_host: process.env.app_host or '0.0.0.0'
	app_port: parseInt process.env.app_port or 3000
	app_name: process.env.app_name
	db_host: process.env.db_host or 'localhost'
	db_name: process.env.db_name
	db_port: parseInt process.env.db_port or 27017

# initialize logger
appLogger = bunyan.createLogger
	name: env.name + ' app server'
	level: process.env.LOG_LEVEL || 'warn'
	stream: process.stdout
	serializers: bunyan.stdSerializers

server = restify.createServer name: process.env.name

server.pre restify.pre.sanitizePath()
server.use restify.acceptParser server.acceptable
server.use restify.queryParser()
server.use restify.bodyParser()
server.use (req, res, next) ->
  res.header "Access-Control-Allow-Origin", "*"
  res.header "Access-Control-Allow-Headers", "X-Requested-With, Content-Type"
  res.header "Access-Control-Allow-Methods", "POST, GET, PUT, DELETE, OPTIONS"
  next()
server.use restify.fullResponse()

# Bunyan
server.on 'after', restify.auditLogger log: appLogger

# Add routes
routes server, env.db_host, env.db_name, env.db_port

# And here we go...
server.listen env.app_port, env.app_host, () ->
	console.log '%s listening at %s', server.name, server.url if process.env['NODE_ENV'] != 'production'


module.exports = ->
	return server
