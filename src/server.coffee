dotenv    = require 'dotenv'
restify   = require 'restify'
bunyan		= require 'bunyan'

routes    = require './routes'

dotenv.load()
app_env =
	port: parseInt process.env.port
	name: process.env.name


# initialize logger
appLogger = bunyan.createLogger
	name: app_env.name + ' app server'
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
routes server

server.listen app_env.port, () ->
  console.log '%s listening at %s', server.name, server.url