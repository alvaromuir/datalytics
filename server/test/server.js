// Generated by CoffeeScript 1.7.1
(function() {
  var app_url, assert, chai, dotenv, ds, env, expect, request, should;

  dotenv = require('dotenv');

  chai = require('chai');

  request = require('request');

  ds = require('../ds');

  should = chai.should();

  expect = chai.expect;

  assert = chai.assert;

  dotenv.load();

  env = {
    app_host: process.env.app_host || '0.0.0.0',
    app_port: parseInt(process.env.app_port || 3000),
    app_name: process.env.app_name,
    db_host: process.env.db_host || 'localhost',
    db_name: process.env.db_name,
    db_port: parseInt(process.env.db_port || 27017)
  };

  app_url = 'http://' + env.app_host + ':' + env.app_port;

  describe('The application server', function() {
    before(function(done) {
      return request(app_url, function(err, res, data) {
        var app;
        if (!err && res.statusCode === 200) {
          return done();
        } else {
          app = require('../server');
          return done();
        }
      });
    });
    return describe('when listening', function() {
      return it('should respond to GET request', function(done) {
        return request(app_url, function(err, res, data) {
          var body;
          if (!err && res.statusCode === 200) {
            body = JSON.parse(data);
            expect(body.code).to.not.equal('ResourceNotFound');
            expect(body.server).to.equal(env.app_name);
            return done();
          }
        });
      });
    });
  });

}).call(this);
